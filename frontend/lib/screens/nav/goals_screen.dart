import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Future<List<TransactionModel>> futureTransactions;
  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    futureTransactions = api.getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
      future: futureTransactions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar os itens: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final item = transactions[index];
              return ListTile(
                title: Text(item.title ?? ''),
                subtitle: Text(item.value.toString()),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Nenhum item encontrado.'),
          );
        }
      },
    );
  }
}

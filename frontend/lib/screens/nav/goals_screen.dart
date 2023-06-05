import 'dart:convert';
import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<TransactionModel> transactions = [];
  ApiService api = ApiService();
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obterTransacoes();
  }

  Future<void> obterTransacoes() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<TransactionModel> fetchedTransactions =
          await api.getUserTransactions();
      setState(() {
        transactions = fetchedTransactions;
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao obter transações: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'JSON completo:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: isLoading
                ? Center(
                    child:
                        CircularProgressIndicator()) // Mostrar tela de carregamento
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        jsonEncode(transactions),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

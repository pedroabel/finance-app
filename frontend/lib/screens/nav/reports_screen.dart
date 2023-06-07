import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/api.dart';
import '../../widgets/bar_graph.dart';
import '../../widgets/transactions_tile.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<List<TransactionModel>> futureTransactions;
  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    futureTransactions = api.getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<double> weeklySummary = [
      7.40,
      2.58,
      5.40,
      4.58,
      3.40,
      8.58,
      9.01,
      2.58,
    ];

    return Scaffold(
      //BODY
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 35% of our total height
            height: size.height * .65,
            decoration: BoxDecoration(
              color: Colors.blue[800],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                children: [
                  //NAVBAR
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.workspaces,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_rounded,
                              color: Colors.white),
                          SizedBox(width: 16.0),
                          Icon(Icons.settings_rounded, color: Colors.white)
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 25),

                  //TITLE
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Relatorio",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "Ultimas transações criadas recentemente",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  //GRAFICO
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 300.0, // Minimum height
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white),
                    child: Center(
                      child: SizedBox(
                        height: 200,
                        child: MyBarGraph(
                          weeklySummary: weeklySummary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),
                  Expanded(
                    child: Center(
                      child: Column(children: [
                        //Titulo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Todos",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.indigo[900]),
                            ),
                            const SizedBox(width: 34),
                            Text(
                              "Despesas",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.indigo[300]),
                            ),
                            const SizedBox(width: 34),
                            Text(
                              "Rendas",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.indigo[300]),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),

                  //TRANSACTIONS
                  Expanded(
                    child: FutureBuilder<List<TransactionModel>>(
                      future: futureTransactions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final transactions = snapshot.data!;
                          return ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return TransactionsTile(
                                icon: Icons.fastfood_rounded,
                                transactions: transaction.title ?? '',
                                price: "R\$ ${transaction.value ?? ''}",
                                type: transaction.type ?? '',
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error ao carregar os itens: ${snapshot.error}');
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

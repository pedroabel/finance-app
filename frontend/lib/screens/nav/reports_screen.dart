import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/api.dart';
import '../../widgets/transactions_tile.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<List<TransactionModel>> futureTransactions;
  ApiService api = ApiService();
  late String selectedFilter = "Todos";
  late Future<double> futureIncome;
  late Future<double> futureExpense;
  late List<double> weeklySummary = [0.0, 0.0];

  List<PieChartSectionData> generateChartData(
      double totalRendas, double totalDespesas) {
    final List<Color> colors = [Colors.green, Colors.redAccent];

    double sectionRadius = 40.0; // Tamanho uniforme das seções

    return [
      PieChartSectionData(
        value: totalRendas,
        color: colors[0],
        title: 'R\$ ${totalRendas.toStringAsFixed(2)}',
        radius: sectionRadius,
        titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      PieChartSectionData(
        value: totalDespesas,
        color: colors[1],
        title: 'R\$ ${totalDespesas.toStringAsFixed(2)}',
        radius: sectionRadius,
        titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    futureTransactions = api.getUserTransactions();
    futureIncome = api.getUserIncome();
    futureExpense = api.getUserExpense();

    // Esperar pelos valores dos futuros e atribuí-los a weeklySummary
    Future.wait([futureIncome, futureExpense]).then((values) {
      // ignore: unnecessary_null_comparison
      if (values[0] != null && values[1] != null) {
        weeklySummary = values.map((value) => value).toList();
      }
      setState(() {}); // Atualizar o estado para reconstruir a interface
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      //BODY
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 35% of our total height
            height: size.height * .22,
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
                          Text("Relatório",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "Últimas transações criadas recentemente",
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
                      minHeight: 250.0, // Minimum height
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                      sections: generateChartData(
                                          weeklySummary[0], weeklySummary[1]),
                                      centerSpaceRadius: 48.0),
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'R\$ ${(weeklySummary[0] - weeklySummary[1]).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Rendas',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Despesas',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          // Título
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = "Todos";
                                  });
                                },
                                child: Text(
                                  "Todos",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: selectedFilter == "Todos"
                                        ? Colors.indigo[900]
                                        : Colors.indigo[300],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 34),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = "Despesas";
                                  });
                                },
                                child: Text(
                                  "Despesas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: selectedFilter == "Despesas"
                                        ? Colors.indigo[900]
                                        : Colors.indigo[300],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 34),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = "Rendas";
                                  });
                                },
                                child: Text(
                                  "Rendas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: selectedFilter == "Rendas"
                                        ? Colors.indigo[900]
                                        : Colors.indigo[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Expanded(
                            child: FutureBuilder<List<TransactionModel>>(
                              future: futureTransactions,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final transactions = snapshot.data!;
                                  List<TransactionModel> filteredTransactions =
                                      [];

                                  if (selectedFilter == "Despesas") {
                                    filteredTransactions = transactions
                                        .where((transaction) =>
                                            transaction.type == "Despesa")
                                        .toList();
                                  } else if (selectedFilter == "Rendas") {
                                    filteredTransactions = transactions
                                        .where((transaction) =>
                                            transaction.type == "Renda")
                                        .toList();
                                  } else {
                                    filteredTransactions = transactions;
                                  }

                                  return ListView.builder(
                                    itemCount: filteredTransactions.length,
                                    itemBuilder: (context, index) {
                                      final transaction =
                                          filteredTransactions[index];
                                      return TransactionsTile(
                                        icon: Icons.wallet_rounded,
                                        transactions: transaction.title ?? '',
                                        price:
                                            "R\$ ${transaction.value?.toStringAsFixed(2).replaceAll('.', ',') ?? '0,00'}",
                                        type: transaction.type ?? '',
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Error ao carregar os itens: ${snapshot.error}');
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ],
                      ),
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

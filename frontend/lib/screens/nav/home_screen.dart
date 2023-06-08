import 'package:finance/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/api.dart';
import '../../widgets/transactions_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService api = ApiService();
  late Future<List<TransactionModel>> futureTransactions;

  @override
  void initState() {
    super.initState();
    futureTransactions = api.getUserTransactions();
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
            height: size.height * .35,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.workspaces,
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
                          Text("DASHBOARD",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "Sua gestão financeira desse mês",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  //OVERVIEW
                  Container(
                    padding: const EdgeInsets.all(28.0),
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 250.0, // Minimum height
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //UPSIDE
                        const Text(
                          "Saldo Atual",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),

                        //---VALUES
                        Row(
                          children: [
                            Text(
                              "R\$ 106.00",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 30),

                            //PERCENT
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple[900],
                              ),
                              child: const Row(children: [
                                Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.white,
                                ),
                                Text(
                                  "8%",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Divider(
                          color: Colors.indigo[100],
                        ),

                        const SizedBox(height: 15),

                        //DOWNSIDE

                        //---EXPENSES + INCOMES
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Expenses
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.wallet_rounded,
                                        color: Colors.lightBlue,
                                        size: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Despesas",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "R\$ 1.250",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),

                            //Incomes
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.lightBlue,
                                        size: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rendas",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "R\$ 1.356",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        //TIPS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_rounded,
                                  color: Colors.lightGreen,
                                  size: 28,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  "Aprimorar conhecimentos e \nhabilidades na gestão financeira. ",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.indigo[50],
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Colors.indigo,
                                size: 28,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  //TRANSACTIONS
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          // Título
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Todos",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.indigo[900],
                                ),
                              ),
                              const SizedBox(width: 34),
                              Text(
                                "Despesas",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.indigo[300],
                                ),
                              ),
                              const SizedBox(width: 34),
                              Text(
                                "Rendas",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.indigo[300],
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
                                  return ListView.builder(
                                    itemCount: transactions.length,
                                    itemBuilder: (context, index) {
                                      final transaction = transactions[index];
                                      return TransactionsTile(
                                        icon: Icons.wallet_rounded,
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

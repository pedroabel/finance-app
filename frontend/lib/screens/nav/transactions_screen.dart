import 'package:flutter/material.dart';

import '../../widgets/bar_graph.dart';
import '../../widgets/transactions_tile.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

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
                            Text("TRANSAÇÕES",
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
                      padding: const EdgeInsets.all(28.0),
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
                            )),
                      ),
                    ),

                    const SizedBox(height: 35),
                    //TRANSACTIONS
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
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

                            const SizedBox(height: 20),
                            Expanded(
                                child: ListView(
                              children: const [
                                TransactionsTile(
                                  icon: Icons.fastfood_rounded,
                                  transactions: "Comida - iFood",
                                  price: "R\$ 25,00",
                                ),
                                TransactionsTile(
                                  icon: Icons.cut_rounded,
                                  transactions: "Barbeiro",
                                  price: "R\$ 45,00",
                                ),
                                TransactionsTile(
                                  icon: Icons.shopping_cart_rounded,
                                  transactions: "Mercado",
                                  price: "R\$ 300,00",
                                ),
                                TransactionsTile(
                                  icon: Icons.payments_rounded,
                                  transactions: "Pix",
                                  price: "R\$ 100,00",
                                ),
                                TransactionsTile(
                                  icon: Icons.theater_comedy_rounded,
                                  transactions: "Cinema",
                                  price: "R\$ 18,00",
                                ),
                                TransactionsTile(
                                  icon: Icons.icecream_rounded,
                                  transactions: "Milkshake",
                                  price: "R\$ 25,00",
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

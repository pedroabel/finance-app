import 'package:flutter/material.dart';

import '../../utils/transactions_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //BODY
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 35% of our total height
            height: size.height * .16,
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
                                "R\$ 106,00",
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
                                          size: 40,
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
                                            "R\$ 1,250",
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 20,
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
                                          size: 40,
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
                                            "R\$ 1,356",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.indigo[50],
                                ),
                                child: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Colors.indigo,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    //TRANSACTIONS
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            //Titulo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transações",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.indigo[900]),
                                ),
                                const Text(
                                  "Ver todos",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.lightBlue),
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

import 'package:flutter/material.dart';

import '/screens/nav/goals_page.dart';
import '/screens/nav/home_page.dart';
import '/screens/nav/reports_page.dart';
import '/screens/nav/transactions_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const TransactionsPage(),
    const ReportsPage(),
    const GoalsPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        elevation: 0,
        selectedItemColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments), label: "Transactions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: "Reports"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notes_rounded), label: "Goals"),
        ],
      ),
    );
  }
}

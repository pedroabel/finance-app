import 'package:flutter/material.dart';

import '../services/api.dart';
import 'nav/goals_screen.dart';
import 'nav/home_screen.dart';
import 'nav/report_screen.dart';
import 'nav/transactions_screen.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  ApiService api = ApiService();

  Future<String?> getTokenFromAPI() async {
    String? token = await api.getToken();
    return token;
  }

  List pages = [
    const HomeScreen(),
    const TransactionsScreen(),
    const ReportScreen(),
    const GoalsScreen(),
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

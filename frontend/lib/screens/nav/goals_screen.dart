import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Future<UserModel?> futureUserData;
  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUserData();
  }

  Future<UserModel?> fetchUserData() async {
    try {
      return await api.getUserData();
    } catch (error) {
      // Trate o erro conforme necessário
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: futureUserData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child:
                Text('Erro ao carregar os dados do usuário: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: ${user.name}'),
              Text('Email: ${user.email}'),
              Text('Idade: ${user.balance}'),
              // Exiba outros campos do UserModel conforme necessário
            ],
          );
        } else {
          return const Center(
            child: Text('Nenhum dado de usuário encontrado.'),
          );
        }
      },
    );
  }
}

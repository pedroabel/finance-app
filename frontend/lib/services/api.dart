import 'dart:convert';

import 'package:finance/models/transaction_model.dart';
import 'package:finance/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService();

  static const String baseUrl = 'http://104.196.223.167:8080';

  var userId = 1;

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return token ?? '';
  }

  Future<bool> loginRequest(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Uri.parse('$baseUrl/login');
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      var body = response.body;
      var jsonData = jsonDecode(body);

      var token = jsonData['token'];

      await preferences.setString("token", token);
      return true;
    } else {
      throw Exception('Falha no login');
    }
  }

  Future<String> createUser(
      String name, String email, String password, String balance) async {
    var url = Uri.http(baseUrl, '/login');

    var response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'balance': balance,
    });

    if (response.statusCode == 201) {
      return 'Usuario criado com sucesso';
    } else {
      throw Exception('Falha na criação de usuario');
    }
  }

  Future<UserModel> getUserData(String token) async {
    var url = Uri.http(baseUrl, '/transactions', {'id': '$userId'});
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var userData = await jsonDecode(response.body);
      return UserModel.fromJson(userData);
    } else {
      throw Exception("Error in getUserData");
    }
  }

  Future<List<TransactionModel>> getUserTransactions(String? token) async {
    var url = Uri.http(baseUrl, '/transactions');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      var transactionsData = jsonDecode(response.body);
      List<TransactionModel> transactions = [];

      for (var transactionData in transactionsData) {
        transactions.add(TransactionModel.fromJson(transactionData));
      }

      return transactions;
    } else {
      throw Exception('Falha ao obter transacoes do usuario');
    }
  }
}

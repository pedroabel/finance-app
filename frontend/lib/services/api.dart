import 'dart:convert';
import 'dart:developer';

import 'package:finance/models/transaction_model.dart';
import 'package:finance/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService();

  static const String baseUrl = 'http://104.196.223.167:8080';

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return token;
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
      var userID = jsonData['UserID'];

      await preferences.setString("token", token);
      await preferences.setInt("UserID", userID);

      return true;
    } else {
      throw Exception('Falha no login');
    }
  }

  Future<bool> createUser(
      String name, String email, String password, double balance) async {
    var url = Uri.parse('$baseUrl/user');
    var body = jsonEncode(
        {'name': name, 'email': email, 'password': password, 'balance': 0.0});

    var response = await http.post(url, body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Falha na criação de usuario');
    }
  }

  Future<UserModel> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("UserID");
    var token = await getToken();
    var url = Uri.parse('$baseUrl/user?id=$userId');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = UserModel.fromJson(data);
      log(response.body);

      return user;
    } else {
      throw Exception("Error in getUserData");
    }
  }

  Future<List<TransactionModel>> getUserTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/transactions?id=$userId');
    var token = getToken(); // Aguarda a obtenção do token
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final transactions = List<TransactionModel>.from(
          data.map((json) => TransactionModel.fromJson(json)));

      return transactions;
    } else {
      throw Exception('Falha ao obter transacoes do usuario');
    }
  }

  Future<List<TransactionModel>> getExpenseTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/transactions?id=$userId');
    var token = getToken(); // Aguarda a obtenção do token
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final transactions = List<TransactionModel>.from(
          data.map((json) => TransactionModel.fromJson(json)));

      return transactions;
    } else {
      throw Exception('Falha ao obter transacoes do usuario');
    }
  }

  Future<List<TransactionModel>> getIncomeTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/transactions?id=$userId');
    var token = getToken(); // Aguarda a obtenção do token
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final transactions = List<TransactionModel>.from(
          data.map((json) => TransactionModel.fromJson(json)));

      return transactions;
    } else {
      throw Exception('Falha ao obter transacoes do usuario');
    }
  }

  Future<bool> createTransactions(
      String title, String type, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiService api = ApiService();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/transactions');
    var token = await api.getToken(); // Aguarda a obtenção do token
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode(
        {'title': title, 'type': type, 'value': value, 'userId': userId});

    var response = await http.post(url, body: body, headers: headers);
    await updateBalance(value, type);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Falha na criação de usuário');
    }
  }

  Future<bool> updateBalance(double value, String? type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiService api = ApiService();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/user/saldo');
    var token = await api.getToken(); // Aguarda a obtenção do token
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var user = await getUserData();
    UserModel userData = user;
    var balance = userData.balance;
    double parsedValue = value;
    double? parsedBalance = balance;
    double totalBalance = 0.0;

    type == "Renda"
        ? totalBalance = (parsedBalance! + parsedValue)
        : totalBalance = (parsedBalance! - parsedValue);

    var body = jsonEncode({'balance': totalBalance, 'id': userId});

    var response = await http.put(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Falha na atualização de saldo');
    }
  }
}

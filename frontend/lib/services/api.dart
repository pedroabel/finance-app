import 'dart:convert';

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
      String name, String email, String password, String balance) async {
    var url = Uri.parse('$baseUrl/user');
    var body = jsonEncode(
        {'name': name, 'email': email, 'password': password, 'balance': "0"});

    var response = await http.post(url, body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Falha na criação de usuario');
    }
  }

  Future<UserModel> getUserData(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString("UserID");

    var url = Uri.parse('$baseUrl/user?id=$userId');
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

  Future<List<TransactionModel>> getUserTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiService api = ApiService();
    var userId = preferences.getInt("UserID");
    var url = Uri.parse('$baseUrl/transactions?id=$userId');
    var token = await api.getToken(); // Aguarda a obtenção do token
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
}

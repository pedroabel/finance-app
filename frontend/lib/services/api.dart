import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://104.196.223.167:8080';

  Future<String> loginRequest(String email, String password) async {
    var url = Uri.http(baseUrl, '/login');

    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var token = response.body;
      return token;
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
      var token = response.body;
      return token;
    } else {
      throw Exception('Falha na criação de usuario');
    }
  }
}

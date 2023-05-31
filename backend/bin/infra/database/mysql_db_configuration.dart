import 'package:mysql1/mysql1.dart';

import 'db_configuration.dart';

class MySQLConfiguration extends DBConfiguration {
  MySqlConnection? _connection;

  @override
  // TODO: implement connection
  Future get connection async {
    if (_connection == null) _connection = await createConnection();

    if (_connection == null)
      throw Exception('[ERROR] - Failed create connection');

    return _connection;
  }

  @override
  Future createConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'dart_user',
        password: 'dart_pass',
        db: 'dart',
      ),
    );
  }

  @override
  execQuery(String sql, [List? parms]) {
    // TODO: implement execQuery
    throw UnimplementedError();
  }
}

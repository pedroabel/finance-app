import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future<bool> create(UserModel value) async {
    var result = await _execQuery(
        'INSERT INTO usuarios (nome, email, senha, saldo) VALUES (?,?,?,?)',
        [value.name, value.email, value.password, value.balance]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _execQuery('DELETE FROM usuarios WHERE id = ?', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _execQuery('SELECT * FROM usuarios');
    return result
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);
    return result.affectedRows == 0
        ? null
        : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _execQuery(
      'UPDATE usuarios SET nome = ?, senha = ? WHERE id = ?',
      [value.name, value.password, value.id],
    );

    return result.affectedRows > 0;
  }

  _execQuery(String sql, [List? params]) async {
    var connection = await _dbConfiguration.connection;
    return await connection.query(sql, params);
  }
}

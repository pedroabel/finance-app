import '../infra/database/db_configuration.dart';
import '../models/transaction_model.dart';
import 'dao.dart';

class TransactionDAO implements DAO<TransactionModel> {
  final DBConfiguration _dbConfiguration;
  TransactionDAO(this._dbConfiguration);

  @override
  Future<bool> create(TransactionModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO transacoes (id, titulo, tipo, valor, id_usuario) VALUES (?,?,?,?,?)',
        [
          value.id,
          value.title,
          value.type,
          value.value,
          value.userId,
        ]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE FROM transacoes WHERE id = ?', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<TransactionModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM transacoes');
    return result
        .map((r) => TransactionModel.fromMap(r.fields))
        .toList()
        .cast<TransactionModel>();
  }

  Future<List<TransactionModel>> findAllFromUser(int userId) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM transacoes WHERE id_usuario = ?', [userId]);
    return result
        .map((r) => TransactionModel.fromMap(r.fields))
        .toList()
        .cast<TransactionModel>();
  }

  @override
  Future<TransactionModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM transacoes WHERE id = ?', [id]);
    return result.isEmpty
        ? null
        : TransactionModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(TransactionModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE transacoes SET titulo = ?, valor = ? WHERE id = ?',
      [value.title, value.value, value.id],
    );

    return result.affectedRows > 0;
  }

  Future<TransactionModel?> findUser(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM transacoes WHERE id_usuario = ?', [id]);
    return result.isEmpty
        ? null
        : TransactionModel.fromMap(result.first.fields);
  }
}

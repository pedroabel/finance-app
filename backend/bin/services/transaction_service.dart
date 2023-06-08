import '../dao/transaction_dao.dart';
import '../models/transaction_model.dart';
import 'generic_service.dart';

class TransactionService implements GenericService<TransactionModel> {
  final TransactionDAO _transactionDAO;
  TransactionService(this._transactionDAO);

  @override
  Future<bool> delete(int id) {
    return _transactionDAO.delete(id);
  }

  @override
  Future<List<TransactionModel>> findAll() {
    return _transactionDAO.findAll();
  }

  @override
  Future<TransactionModel?> findOne(int id) {
    return _transactionDAO.findOne(id);
  }

  Future<TransactionModel?> findUser(int id) {
    return _transactionDAO.findUser(id);
  }

  Future<List<TransactionModel>> findAllFromUser(int id) {
    return _transactionDAO.findAllFromUser(id);
  }

  @override
  Future<bool> save(TransactionModel value) async {
    if (value.id != null) {
      return _transactionDAO.update(value);
    } else {
      return _transactionDAO.create(value);
    }
  }
}

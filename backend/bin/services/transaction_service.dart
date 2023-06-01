import '../models/transaction_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class TransactionService implements GenericService<TransactionModel> {
  final List<TransactionModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return delete(id);
  }

  @override
  Future<List<TransactionModel>> findAll() {
    return findAll();
  }

  @override
  Future<TransactionModel> findOne(int id) {
    return findOne(id);
  }

  @override
  Future<bool> save(TransactionModel value) {
    TransactionModel? model = _fakeDB.firstWhereOrNull(
      (e) => e.id == value.id,
    );

    //CREATE
    if (model == null) {
      _fakeDB.add(value);
    }

    //UPDATE
    if (model != null) {
      var index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }

    return save(value);
  }
}

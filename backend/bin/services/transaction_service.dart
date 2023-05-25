import '../models/transaction_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class TransactionService implements GenericService<TransactionModel> {
  final List<TransactionModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<TransactionModel> findAll() {
    return _fakeDB;
  }

  @override
  TransactionModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(TransactionModel value) {
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

    return true;
  }
}

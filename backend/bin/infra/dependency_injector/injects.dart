import '../../apis/login_api.dart';
import '../../apis/transactions_api.dart';
import '../../models/transaction_model.dart';
import '../../services/generic_service.dart';
import '../../services/transaction_service.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();
    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginAPI>(() => LoginAPI(di()));

    di.register<GenericService<TransactionModel>>(() => TransactionService());

    di.register(() => TransactionsAPI(di()));

    return di;
  }
}

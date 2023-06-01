import '../../apis/login_api.dart';
import '../../apis/transactions_api.dart';
import '../../apis/user_api.dart';
import '../../dao/user_dao.dart';
import '../../models/transaction_model.dart';
import '../../services/generic_service.dart';
import '../../services/transaction_service.dart';
import '../../services/user_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySQLConfiguration());

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginAPI>(() => LoginAPI(di.get()));

    di.register<GenericService<TransactionModel>>(() => TransactionService());
    di.register<TransactionsAPI>(
        () => TransactionsAPI(di.get<GenericService<TransactionModel>>()));

    di.register<UserDAO>(() => UserDAO(di.get<DBConfiguration>()));
    di.register<UserService>(() => UserService(di.get<UserDAO>()));
    di.register<UserAPI>(() => UserAPI(di.get<UserService>()));

    return di;
  }
}

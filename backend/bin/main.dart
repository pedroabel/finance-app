import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'apis/login_api.dart';
import 'apis/transactions_api.dart';
import 'dao/user_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/user_model.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  UserDAO _userDAO = UserDAO(_di.get<DBConfiguration>());

  var cascadeHandler = Cascade()
      .add(_di.get<LoginAPI>().getHandler())
      .add(_di.get<TransactionsAPI>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(handler);

  // await CustomServer().initialize(
  //   handler: handler,
  //   address: await CustomEnv.get<String>(key: 'server_address'),
  //   port: await CustomEnv.get<int>(key: 'server_port'),
  // );
}

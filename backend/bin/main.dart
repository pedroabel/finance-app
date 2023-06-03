import 'package:shelf/shelf.dart';
import 'apis/login_api.dart';
import 'apis/transactions_api.dart';
import 'apis/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginAPI>().getHandler())
      .add(_di.get<TransactionsAPI>().getHandler(isSecurity: false))
      .add(_di.get<UserAPI>().getHandler(isSecurity: false))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(handler);

  // await CustomServer().initialize(
  //   handler: handler,
  //   address: await CustomEnv.get<String>(key: 'server_address'),
  //   port: await CustomEnv.get<int>(key: 'server_port'),
  // );
}

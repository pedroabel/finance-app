import 'package:shelf/shelf.dart';

import 'apis/login_api.dart';
import 'apis/transactions_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/transaction_service.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env');

  SecurityService _securityService = SecurityServiceImp();

  var cascadeHandler = Cascade()
      .add(LoginAPI(SecurityServiceImp()).getHandler())
      .add(TransactionsAPI(TransactionService()).getHandler(
        middlewares: [
          _securityService.auth,
          _securityService.verifyJWT,
        ],
      ))
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

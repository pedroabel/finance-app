import 'package:shelf/shelf.dart';

import 'api/login_api.dart';
import 'api/transactions_api.dart';
import 'infra/custom_server.dart';

void main() async {
  var cascadeHandler =
      Cascade().add(LoginAPI().handler).add(TransactionsAPI().handler).handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(handler);
}

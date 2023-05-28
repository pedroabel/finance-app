import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';

class LoginAPI {
  final SecurityService _securityService;
  LoginAPI(this._securityService);

  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) async {
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);

      return Response.ok(token);
    });

    return router;
  }
}

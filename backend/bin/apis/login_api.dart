import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginAPI {
  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) {
      return Response.ok('API de login');
    });

    return router;
  }
}

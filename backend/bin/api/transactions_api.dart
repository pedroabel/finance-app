import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class TransactionsAPI {
  Handler get handler {
    Router router = Router();

    router.get('/transactions', (Request req) {
      return Response.ok('API de transactions');
    });

    return router;
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/transaction_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class TransactionsAPI extends API {
  final GenericService<TransactionModel> _service;
  TransactionsAPI(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    //All transactions
    router.get('/transactions', (Request req) {
      List<TransactionModel> transactions = _service.findAll();
      List<Map> transactionsMap = transactions.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(transactionsMap),
          headers: {'content-type': "application/json"});
    });

    //Create transactions
    router.post('/transactions', (Request req) async {
      var body = await req.readAsString();
      var result = _service.save(
        TransactionModel.fromJson(jsonDecode(body)),
      );
      return result ? Response(201) : Response(500);
    });

    //Update transactions
    router.put('/transactions', (Request req) {
      // String? id = req.url.queryParameters['id'];
      // _service.save("");

      return Response.ok('');
    });

    //Delete transactions
    router.delete('/transactions', (Request req) {
      // String? id = req.url.queryParameters['id'];
      // _service.delete(1);
      return Response.ok('');
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}

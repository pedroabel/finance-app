import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/transaction_model.dart';
import '../services/transaction_service.dart';
import 'api.dart';

class TransactionsAPI extends API {
  final TransactionService _service;
  TransactionsAPI(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    //get one transaction
    router.get('/transaction', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var transaction = await _service.findUser(int.parse(id));
      if (transaction == null) return Response(400);

      return Response.ok(jsonEncode(transaction.toJson()));
    });

    //All transactions
    router.get('/transactions', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      List<TransactionModel> transactions =
          await _service.findAllFromUser(int.parse(id));
      List<Map> transactionsMap = transactions.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(transactionsMap));
    });

    //All transactions
    router.get('/transactions/all', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      List<TransactionModel> transactions = await _service.findAll();
      List<Map> transactionsMap = transactions.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(transactionsMap));
    });

    //Create transactions
    router.post('/transactions', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(
        TransactionModel.fromRequest(jsonDecode(body)),
      );
      return result ? Response(201) : Response(500);
    });

    //Update transactions
    router.put('/transactions', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(
        TransactionModel.fromRequest(jsonDecode(body)),
      );
      return result ? Response(200) : Response(500);
    });

    //Delete transactions
    router.delete('/transactions', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

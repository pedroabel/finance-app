import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserAPI extends API {
  final UserService _userService;
  UserAPI(this._userService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    final router = Router();

    //get user
    router.get('/user', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var user = await _userService.findOne(int.parse(id));
      if (user == null) return Response(400);

      return Response.ok(jsonEncode(user.toJson()));
    });

    //update user
    router.put('/user', (Request req) async {
      var body = await req.readAsString();
      var result = await _userService.save(
        UserModel.fromRequest(jsonDecode(body)),
      );
      return result ? Response(200) : Response(500);
    });

    //update balance
    router.put('/user/saldo', (Request req) async {
      var body = await req.readAsString();
      var result = await _userService.updateBalance(
        UserModel.fromRequest(jsonDecode(body)),
      );
      return result ? Response(200) : Response(500);
    });

    //create user
    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var user = UserModel.fromRequest(jsonDecode(body));

      var result = await _userService.save(user);

      return result ? Response(201) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

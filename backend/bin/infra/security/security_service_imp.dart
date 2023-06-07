import 'package:shelf/shelf.dart';

import 'security_service.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  SecurityServiceImp() {
    print("Created Object ${DateTime.now().microsecondsSinceEpoch}");
  }

  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user'],
    });

    // String key = await CustomEnv.get(key: 'jwt_key');
    String key = 'dartSecretkey';
    String token = jwt.sign(SecretKey(key));

    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    // String key = await CustomEnv.get(key: "jwt_key");
    String key = 'dartSecretkey';

    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTExpiredException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get auth {
    return (Handler handler) {
      return (Request req) async {
        String? authHeader = req.headers['Authorization'];
        JWT? jwt;

        if (authHeader != null) {
          if (authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }

        var request = req.change(context: {'jwt': jwt});

        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(
        requestHandler: (Request req) {
          if (req.context['jwt'] == null) {
            return Response.forbidden("Not auth");
          }
          return null;
        },
      );
}

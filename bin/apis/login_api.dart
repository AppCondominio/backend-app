import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/login_service.dart';
import '../to/auth_to.dart';
import 'api.dart';

class LoginApi extends Api {
  final LoginService _loginService;
  LoginApi(this._loginService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.post('/login', (Request req) async {
      var body = await req.readAsString();
      var authTO = AuthTO.fromRequest(body);

      var result = await _loginService.authenticate(authTO);
      if (result != null) {
        return Response.ok(jsonEncode(result.toJsonLogin()));
      } else {
        return Response(401, body: 'Invalid document or password.');
      }
    });
    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

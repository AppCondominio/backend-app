import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../models/user_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final GenericService<UserModel> _service;
  LoginApi(this._securityService, this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.post('/login', (Request req) async {
      var res = await req.readAsString();
      var body = jsonDecode(res);
      var document = body['documentNumber'];
      var password = body['password'];

      List<UserModel> listRegisters = _service.findAll();
      List<Map> listRegistersMap =
          listRegisters.map((e) => e.toJson()).toList();

      if (res.isNotEmpty) {
        var userEncontrado = listRegistersMap.firstWhere(
            (e) => e['documentNumber'] == document,
            orElse: () => {});
        if (document == userEncontrado["documentNumber"] &&
            password == userEncontrado["password"]) {
          var tokenVerificated =
              await _securityService.validateJWT(userEncontrado["jwtToken"]);
          if (tokenVerificated != null) {
            return Response.ok("You made login!");
          }
        }
      }
      return Response.forbidden('Not Authorized');
    });
    return createHandler(router: router);
  }
}

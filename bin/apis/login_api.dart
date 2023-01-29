import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../models/condo_model.dart';
import '../models/user_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final GenericService<UserModel> _serviceUser;
  final GenericService<CondoModel> _serviceCondo;
  LoginApi(this._securityService, this._serviceUser, this._serviceCondo);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.post('/login', (Request req) async {
      var res = await req.readAsString();
      var body = jsonDecode(res);
      String document = body['documentNumber'];
      String password = body['password'];

      List<CondoModel> listRegistersCondo = _serviceCondo.findAll();
      List<Map> listRegistersCondoMap =
          listRegistersCondo.map((e) => e.toJson()).toList();

      List<UserModel> listRegistersUser = _serviceUser.findAll();
      List<Map> listRegistersUserMap =
          listRegistersUser.map((e) => e.toJson()).toList();

      if (res.isNotEmpty) {

        // Caso seja CNPJ
        if (document.length == 14) {
          var condoEncontrado = listRegistersCondoMap.firstWhere(
              (e) => e['documentNumber'] == document,
              orElse: () => {});
          if (document == condoEncontrado["documentNumber"] &&
              password == condoEncontrado["password"]) {
            return Response.ok(jsonEncode(condoEncontrado));
          }
        }

        var userEncontrado = listRegistersUserMap.firstWhere(
            (e) => e['documentNumber'] == document,
            orElse: () => {});
        if (document == userEncontrado["documentNumber"] &&
            password == userEncontrado["password"]) {
          var tokenVerificated =
              await _securityService.validateJWT(userEncontrado["jwtToken"]);
          if (tokenVerificated != null) {
            return Response.ok(jsonEncode(userEncontrado));
          }
        }
      }
      return Response.forbidden('Not Authorized');
    });
    return createHandler(router: router);
  }
}

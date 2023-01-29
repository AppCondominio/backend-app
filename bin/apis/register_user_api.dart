import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../models/user_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterUserApi extends Api {
  final SecurityService _securityService;
  final GenericService<UserModel> _service;

  RegisterUserApi(this._securityService, this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;
    router.post('/register/user', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);
      var token = await _securityService.generateJWT(body['name']);

      Map map = {
        "id": id,
        "name": body['name'],
        "lastName": body['lastName'],
        'documentNumber': body['documentNumber'],
        'email': body['email'],
        'password': body['password'],
        'jwtToken': token
      };

      _service.save(UserModel.fromJson(map));
      return Response(201, body: "User Save Successful");
    });

    router.get('/register/user', (Request req) async {
      List<UserModel> registers = _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

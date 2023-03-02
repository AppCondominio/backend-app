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
        'renter': body['renter'] ? 'Sim' : 'Não',
        'password': body['password'],
        'jwtToken': token,
        'idCondo': body['idCondo']
      };

      _service.save(UserModel.fromJson(map));
      return Response(201, body: "User Save Successful");
    });

    router.get('/user', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) {
        return Response.notFound("nao achei o id");
      }
      UserModel user = _service.findOne(int.parse(id));
      return Response.ok(jsonEncode(user));
    });

    router.get('/users', (Request req) async {
      List<UserModel> registers = _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    router.put('/user/edit', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      var result = await req.readAsString();
      var body = jsonDecode(result);
      UserModel user = _service.findOne(id);
      Map map = {
        'id': id,
        'name': body['name'].toString().isEmpty ? user.name : body['name'],
        'lastName': body['lastName'].toString().isEmpty ? user.lastName : body['lastName'],
        'documentNumber': user.documentNumber,
        'email': body['email'].toString().isEmpty ? user.email : body['email'],
        'renter': body['renter'] ? 'Sim' : 'Não',
        'password': user.password,
        'jwtToken': user.jwtToken
        
      };
      _service.delete(id);
      _service.save(UserModel.fromJson(map));
      return Response.ok("Editado.");
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/src/middleware.dart';

import 'package:shelf/src/handler.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../models/resident_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterResidentApi extends Api {
  final SecurityService _securityService;
  final GenericService<ResidentModel> _service;

  RegisterResidentApi(this._securityService, this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;

    router.post('/register/resident', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);
      Map map = {
        'id': id,
        'room': body['room'],
        'optionalRoom': body['optionalRoom'],
        'idUser': body['idUser']
      };
      _service.save(ResidentModel.fromJson(map));
      return Response.ok("Morador Salvo!");
    });

    router.get('/register/resident', (Request req) async {
      List<ResidentModel> registers = _service.findAll();
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

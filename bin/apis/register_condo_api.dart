import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/condo_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterCondoApi extends Api {
  final GenericService<CondoModel> _service;

  RegisterCondoApi(this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;
    router.post('/register/condo', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);

      

      Map map = {
        "id": id,
        "condoName": body['condoName'],
        'documentNumber': body['documentNumber'],
        'email': body['email'],
        'zipCode': body['zipCode'],
        'numberAddress': body['numberAddress'],
        'optionalAddress': body['optionalAddress'],
        'idUser': body['idUser'],
        'plan': body['plan']
      };

      _service.save(CondoModel.fromJson(map));
      return Response(201, body: "Condo Save Successful");
    });

    router.get('/register/condo', (Request req) async {
      List<CondoModel> registers = _service.findAll();
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

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
        'plan': body['plan'],
        'isSet': body['isSet']
      };

      _service.save(CondoModel.fromJson(map));
      return Response(201, body: "Condo Save Successful");
    });

    router.get('/get/condo', (Request req) async {
      List<CondoModel> registers = _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    router.get('/get/condo', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) {
        return Response.notFound("nao achei o id");
      }
      CondoModel user = _service.findOne(int.parse(id));
      return Response.ok(jsonEncode(user));
    });

    router.put('/edit/condo', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      var result = await req.readAsString();
      var body = jsonDecode(result);
      CondoModel condo = _service.findOne(id);
      Map map = {
        "id": id,
        "condoName": condo.condoName,
        'documentNumber': condo.documentNumber,
        'password': condo.password,
        'email': condo.email,
        'zipCode': condo.zipCode,
        'numberAddress': condo.numberAddress,
        'optionalAddress': condo.optionalAddress,
        'dtCreated': condo.dtCreated,
        'dtUpdated': DateTime.now(),
        'plan': condo.plan,
        'isSet': body['isSet']
      };
      _service.delete(id);
      _service.save(CondoModel.fromJson(map));
      return Response.ok("Editado.");
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/cooperator_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class CooperatorApi extends Api {
  final GenericService<CooperatorModel> _service;
  CooperatorApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;
    router.post('/register/cooperator', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);

      Map map = {
        'id': id,
        'name': body['name'],
        'documentNumber': body['documentNumber'],
        'role': body['role'],
        'idCondo': body['idCondo']
      };

      _service.save(CooperatorModel.fromJson(map));
      return Response(201, body: "Cooperator Saved.");
    });

    router.get('/get/cooperator', (Request req) async {
      String? id = req.url.queryParameters['idCondo'];

      List<CooperatorModel> cooperators = _service.findAll();
      List<Map> cooperatorMap = cooperators.map((e) => e.toJson()).toList();
      var result = cooperatorMap.where((e) => e['idCondo'] == int.parse(id!)).toList();

      return Response.ok(jsonEncode(result));
    });

    router.delete('/delete/cooperator', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      _service.delete(id);
      return Response.ok("Cooperator $id deleted.");
    });

    router.put('/edit/cooperator', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      var result = await req.readAsString();
      var body = jsonDecode(result);
      CooperatorModel cooperator = _service.findOne(id);
      Map map = {
        'id': id,
        'name': body['name'] ?? cooperator.name,
        'documentNumber': body['documentNumber'] ?? cooperator.documentNumber,
        'role': body['role'] ?? cooperator.role,
        'dtCreated': cooperator.dtCreated,
        'dtUpdated': DateTime.now(),
      };
      _service.delete(id);
      _service.save(CooperatorModel.fromJson(map));
      return Response.ok("Cooperator Edited.");
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/cooperator_model.dart';
import '../services/cooperator_service.dart';
import 'api.dart';

class CooperatorApi extends Api {
  final CooperatorService _service;
  CooperatorApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    
    router.post('/cooperator', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(CooperatorModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/cooperator/all', (Request req) async {
      String? idSettingCondo = req.url.queryParameters['idSettingCondo'];
      if (idSettingCondo == null) return Response(400);
      List<CooperatorModel> residents = await _service.findAllBySetting(int.parse(idSettingCondo));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/cooperator', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var cooperator = await _service.findOne(int.parse(id));
      if (cooperator == null) return Response(404);
      return Response.ok(jsonEncode(cooperator.toJson()));
    });

    router.delete('/cooperator', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/cooperator', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(CooperatorModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}

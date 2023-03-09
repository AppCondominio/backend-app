import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/tower_settings_model.dart';
import '../services/tower_settings_service.dart';
import 'api.dart';

class TowerSettingsApi extends Api {
  final TowerSettingService _service;
  TowerSettingsApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/towers', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(TowerSettingsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/towers/all', (Request req) async {
      String? idSettingCondo = req.url.queryParameters['idSettingCondo'];
      if (idSettingCondo == null) return Response(400);
      List<TowerSettingsModel> towers = await _service.findAllBySetting(int.parse(idSettingCondo));
      List<Map> towersMap = towers.map((e) => e.toJson()).toList();
      return Response(200, body: jsonEncode(towersMap));
    });

    router.get('/towers', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var tower = await _service.findOne(int.parse(id));
      if (tower == null) return Response(404);
      return Response.ok(jsonEncode(tower.toJson()));
    });

    router.delete('/towers', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/towers', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(TowerSettingsModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/recreation_model.dart';
import '../services/recreation_service.dart';
import 'api.dart';

class RecreationApi extends Api {
  final RecreationService _service;
  RecreationApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/recreation', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(RecreationModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/recreation/all', (Request req) async {
      String? idSettingCondo = req.url.queryParameters['idSettingCondo'];
      if (idSettingCondo == null) return Response(400);
      List<RecreationModel> residents = await _service.findAllBySetting(int.parse(idSettingCondo));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/recreation', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var residents = await _service.findOne(int.parse(id));
      if (residents == null) return Response(404);
      return Response.ok(jsonEncode(residents.toJson()));
    });

    router.delete('/recreation', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/recreation', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(RecreationModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

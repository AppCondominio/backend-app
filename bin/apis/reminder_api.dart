import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/reminder_model.dart';
import '../services/reminder_service.dart';
import 'api.dart';

class ReminderApi extends Api {
  final ReminderService _service;
  ReminderApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/reminder', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ReminderModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/reminder/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      if (idCondo == null) return Response(400);
      List<ReminderModel> residents = await _service.findAllByIdCondo(int.parse(idCondo));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/reminder', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var residents = await _service.findOne(int.parse(id));
      if (residents == null) return Response(404);
      return Response.ok(jsonEncode(residents.toJson()));
    });

    router.delete('/reminder', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/reminder', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(ReminderModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

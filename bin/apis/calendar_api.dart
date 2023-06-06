import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/calendar_model.dart';
import '../services/calendar_service.dart';
import 'api.dart';

class CalendarApi extends Api {
  final CalendarService _service;
  CalendarApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/calendar', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(CalendarModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/calendar/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      if (idCondo == null) return Response(400);
      List<CalendarModel> residents = await _service.findAllByIdCondo(int.parse(idCondo));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/calendar', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var residents = await _service.findOne(int.parse(id));
      if (residents == null) return Response(404);
      return Response.ok(jsonEncode(residents.toJson()));
    });

    router.delete('/calendar', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/calendar', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(CalendarModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
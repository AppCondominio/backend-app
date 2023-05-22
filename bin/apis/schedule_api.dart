import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/schedule_model.dart';
import '../services/schedule_service.dart';
import 'api.dart';

class ScheduleApi extends Api {
  final ScheduleService _service;
  ScheduleApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/schedule', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ScheduleModel.fromRequest(jsonDecode(body)));
      if (result) {
        var insertedId = await _service.getLastInsertedId();
        return Response(201, body: jsonEncode({'protocol': insertedId}));
      } else {
        return Response(500);
      }
    });

    router.get('/schedule/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      String? idUser = req.url.queryParameters['idUser'];
      String? idRecreation = req.url.queryParameters['idRecreation'];
      if (idCondo == null && idUser == null) return Response(400);
      if (idCondo != null) {
        if (idRecreation != null) {
          List<ScheduleModel> schedules = await _service.findAllByRecreation(int.parse(idRecreation));
          List<Map> schedulesMap = schedules.map((e) => e.toJsonDtSchadule()).toList();
          return Response.ok(jsonEncode(schedulesMap));
        }
        List<ScheduleModel> schedules = await _service.findAllByIdCondo(int.parse(idCondo));
        List<Map> schedulesMap = schedules.map((e) => e.toJson()).toList();
        return Response.ok(jsonEncode(schedulesMap));
      }
      if (idUser != null) {
        List<ScheduleModel> schedules = await _service.findAllByUser(int.parse(idUser));
        List<Map> schedulesMap = schedules.map((e) => e.toJson()).toList();
        return Response.ok(jsonEncode(schedulesMap));
      }
    });

    router.get('/schedule', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.findOne(int.parse(id));
      if (result == null) return Response(404);
      return Response.ok(jsonEncode(result.toJson()));
    });

    router.delete('/schedule', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

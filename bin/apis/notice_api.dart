import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/notice_model.dart';
import '../services/notice_service.dart';
import 'api.dart';

class NoticeApi extends Api {
  final NoticeService _service;
  NoticeApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/notice', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(NoticeModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/notice/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      String? stauts = req.url.queryParameters['status'];
      List<NoticeModel> notices;
      if (idCondo == null) return Response(400);
      if (stauts != null) {
        notices = await _service.findAllByIdCondo(int.parse(idCondo), status: stauts);
      } else {
        notices = await _service.findAllByIdCondo(int.parse(idCondo));
      }
      List<Map> noticesMap = notices.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticesMap));
    });

    router.get('/notice', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var notice = await _service.findOne(int.parse(id));
      if (notice == null) return Response(404);
      return Response.ok(jsonEncode(notice.toJson()));
    });

    router.delete('/notice', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/notice', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(NoticeModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

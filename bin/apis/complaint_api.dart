import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/complaint_model.dart';
import '../services/complaint_service.dart';
import 'api.dart';

class ComplaintApi extends Api {
  final ComplaintService _service;
  ComplaintApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.post('/complaint', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ComplaintModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/complaint/all', (Request req) async {
      List<ComplaintModel> residents = await _service.findAll();
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/complaint/condo', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      if (idCondo == null) return Response(400);
      List<ComplaintModel> residents = await _service.findAllByIdCondo(int.parse(idCondo));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/complaint/resident', (Request req) async {
      String? idResident = req.url.queryParameters['idResident'];
      if (idResident == null) return Response(400);
      List<ComplaintModel> residents = await _service.findAllByIdResident(int.parse(idResident));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/complaint', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var complaint = await _service.findOne(int.parse(id));
      if (complaint == null) return Response(404);
      return Response.ok(jsonEncode(complaint.toJson()));
    });

    router.delete('/complaint', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/complaint', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(ComplaintModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}

import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/resident_model.dart';

import '../services/register_resident_service.dart';
import 'api.dart';

class RegisterResidentApi extends Api {
  final RegisterResidentService _service;
  RegisterResidentApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/resident', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(ResidentModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/resident/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      String? optApartament = req.url.queryParameters['optApartament'];
      if (idCondo == null) return Response(400);
      List<ResidentModel> residents;
      if (optApartament != null) {
        residents = await _service.findAllByTower(int.parse(idCondo), optApartament);
      } else {
        residents = await _service.findAllByCondo(int.parse(idCondo));
      }
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/resident/all/user', (Request req) async {
      String? idUser = req.url.queryParameters['idUser'];
      if (idUser == null) return Response(400);
      List<ResidentModel> residents;
      residents = await _service.findAllByUser(int.parse(idUser));
      List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(residentsMap));
    });

    router.get('/resident', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var residents = await _service.findOne(int.parse(id));
      if (residents == null) return Response(404);
      return Response.ok(jsonEncode(residents.toJson()));
    });

    router.delete('/resident', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/resident', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(ResidentModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

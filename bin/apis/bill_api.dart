import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/bill_model.dart';
import '../services/bill_service.dart';
import 'api.dart';

class BillApi extends Api {
  final BillService _service;
  BillApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/bill', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(BillModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/bill/all', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      String? idResident = req.url.queryParameters['idResident'];
      String? year = req.url.queryParameters['year'];
      if (idCondo == null && idResident == null && year == null) return Response(400);
      if (idCondo != null) {
        List<BillModel> residents = await _service.findAllByIdCondo(int.parse(idCondo));
        List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
        return Response.ok(jsonEncode(residentsMap));
      } else if (idResident != null && year != null) {
        List<BillModel> residents = await _service.findAllByIdResident(int.parse(idResident), year);
        List<Map> residentsMap = residents.map((e) => e.toJson()).toList();
        return Response.ok(jsonEncode(residentsMap));
      }
    });

    router.get('/bill/alltable', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      if (idCondo == null) return Response(400);
      List<Map<String,dynamic>> residents = await _service.findAllForBillTable(int.parse(idCondo));
      return Response.ok(jsonEncode(residents));
    });

    router.delete('/bill', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    router.put('/bill', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(BillModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

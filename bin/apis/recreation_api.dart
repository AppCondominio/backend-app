import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/recreation_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RecreationApi extends Api {
  final GenericService<RecreationModel> _service;
  RecreationApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;
    router.post('/register/recreation', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);

      Map map = {
        'id': id,
        'name': body['name'],
        'price': body['price'],
        'availability': body['availability'],
      };

      _service.save(RecreationModel.fromJson(map));
      return Response(201, body: "Recreation Saved.");
    });

    router.get('/get/recreation', (Request req) async {
      List<RecreationModel> recreations = _service.findAll();
      List<Map> recreationsMap = recreations.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(recreationsMap));
    });

    router.delete('/delete/recreation', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      _service.delete(id);
      return Response.ok("Recreation $id deleted.");
    });

    router.delete('/delete/all/recreation', (Request req) async {
      _service.deleteAll();
      return Response.ok("All recreations was deleted.");
    });

    router.put('/edit/recreation', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      var result = await req.readAsString();
      var body = jsonDecode(result);
      RecreationModel recreation = _service.findOne(id);
      Map map = {
        'id': id,
        'name': body['name'] ?? recreation.name,
        'price': body['price'] ?? recreation.price,
        'availability': body['availability'] ?? recreation.availability,
        'dtCreated': recreation.dtCreated,
        'dtUpdated': DateTime.now(),
      };
      _service.delete(id);
      _service.save(RecreationModel.fromJson(map));
      return Response.ok("Recreation Edited.");
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

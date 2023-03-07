import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/condo_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterCondoApi extends Api {
  final GenericService<CondoModel> _service;

  RegisterCondoApi(this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/register/condo', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var condo = CondoModel.fromRequest(jsonDecode(body));
      var result = await _service.save(condo);
      return result ? Response(201) : Response(500);
    });

    router.get('/get/condo', (Request req) async {
      List<CondoModel> registers = await _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    router.get('/get/condo', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) {
        return Response.notFound("nao achei o id");
      }
      CondoModel? user = await _service.findOne(int.parse(id));
      return Response.ok(jsonEncode(user));
    });

    router.put('/edit/condo', (Request req) async {
      int id = int.parse(req.url.queryParameters['id']!);
      var result = await req.readAsString();
      var body = jsonDecode(result);
      CondoModel? condo = await _service.findOne(id);
      Map map = {
        "id": id,
        "name": condo!.name,
        'document': condo.document,
        'email': condo.email,
        'zipCode': condo.zipCode,
        'addressNumber': condo.addressNumber,
        'optAddress': condo.optAddress,
        'dtCreated': condo.dtCreated,
        'dtUpdated': DateTime.now(),
      };
      _service.delete(id);
      _service.save(CondoModel.fromJson(map));
      return Response.ok("Editado.");
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

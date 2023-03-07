import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/resident_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterResidentApi extends Api {
  final GenericService<ResidentModel> _service;

  RegisterResidentApi(this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;

    router.post('/register/resident', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);
      Map map = {
        'id': id,
        'room': body['room'],
        'optionalRoom': body['optionalRoom'],
        'idUser': body['idUser'],
        'idCondo': body['idCondo']
      };
      _service.save(ResidentModel.fromJson(map));
      return Response.ok("Morador Salvo!");
    });

    router.get('/get/residents', (Request req) async {
      String? id = req.url.queryParameters['idCondo'];

      List<ResidentModel> registers = await _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      var result =
          registerMap.where((e) => e['idCondo'] == int.parse(id!)).toList();
      result.sort(
          ((a, b) => int.parse(a['room']).compareTo(int.parse(b['room']))));
      return Response.ok(jsonEncode(result));
    });

    router.delete('/delete/resident', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) {
        return Response.notFound("nao achei o id");
      }
      _service.delete(int.parse(id));
      return Response.ok("Morador deletado");
    });

    router.get('/get/resident', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) {
        return Response.notFound("nao achei o id");
      }
      ResidentModel? resident = await _service.findOne(int.parse(id));
      return Response.ok(jsonEncode(resident));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

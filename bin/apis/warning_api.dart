import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/warning_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class WarningApi extends Api {
  final GenericService<WarningModel> _service;

  WarningApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;

    router.post('/register/warning', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);

      Map map = {
        'id': id,
        'title': body['title'],
        'description': body['description'],
        'dtToDelete': body['dtToDelete'],
        'idCondo': body['idCondo']
      };

      try {
        _service.save(WarningModel.fromJson(map));
        return Response.ok("Aviso enviado com sucesso.");
      } on Exception {
        return Response.badRequest(body: "Erro ao enviar");
      }
    });

    router.get('/get/all/warning', (Request req) async {
      String? id = req.url.queryParameters['idCondo'];

      List<WarningModel> warnings = _service.findAll();
      List<Map> warningsMap = warnings.map((e) => e.toJson()).toList();

      if (id != null) {
        var result = warningsMap.where((e) => e['idCondo'] == int.parse(id)).toList();
        return Response.ok(jsonEncode(result));
      } else {
        return Response.ok(jsonEncode(warningsMap));
      }
    });

    

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

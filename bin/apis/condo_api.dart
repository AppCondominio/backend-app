import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/condo_settings_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class CondoApi extends Api {
  final GenericService<CondoSettingsModel> _service;
  CondoApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    int id = 0;
    // Config Condo

    // Adicionar configuracao inicial
    router.post('/register/condo/settings', (Request req) async {
      id++;
      var result = await req.readAsString();
      var body = jsonDecode(result);

      Map map = {
        'id': id,
        'towers': body['towers'],
        'recreationArea': body['recreationArea'],
        'cooperator': body['cooperator'],
        'idCondo': body['idCondo']
      };

      _service.save(CondoSettingsModel.fromJson(map));
      return Response(201, body: "Settings Saved.");
    });

    // Recuperar as configuracoes
    router.get('/get/condo/settings', (Request req) async {
      String? id = req.url.queryParameters['idCondo'];
      if (id == null) {
        return Response.notFound("Not found the id -> $id");
      }
      CondoSettingsModel settings = _service.findOne(int.parse(id));
      return Response.ok(jsonEncode(settings));
    });

    // Editar configuracoes
    router.put('/edit/condo/settings', (Request req) async {
      int id = int.parse(req.url.queryParameters['idCondo']!);
      CondoSettingsModel settings = _service.findOne(id);

      var result = await req.readAsString();
      var body = jsonDecode(result);

      Map map = {
        'id': settings.id,
        'towers': body['towers'] ?? settings.towers,
        'recreationArea': body['recreationArea'] ?? settings.recreationArea,
        'cooperator': body['cooperator'] ?? settings.cooperator,
        'dtCreated': settings.dtCreated,
        'dtUpdated': 'a',
        'idCondo': settings.idCondo
      };

      _service.delete(settings.id!);
      _service.save(CondoSettingsModel.fromJson(map));
      return Response.ok("Settings Edited.");
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

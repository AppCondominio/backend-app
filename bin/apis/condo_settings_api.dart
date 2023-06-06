import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/condo_settings_model.dart';
import '../services/condo_settings_service.dart';
import 'api.dart';

class CondoSettingsApi extends Api {
  final CondoSettingsService _service;
  CondoSettingsApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/condo/settings', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(CondoSettingsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/condo/settings', (Request req) async {
      String? idCondo = req.url.queryParameters['idCondo'];
      if (idCondo == null) return Response(400);
      var settings = await _service.findOne(int.parse(idCondo));
      if (settings == null) return Response(404, body: 'Not Found');
      return Response(200, body: jsonEncode(settings.toJson()));
    });

    router.put('/condo/settings', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(CondoSettingsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

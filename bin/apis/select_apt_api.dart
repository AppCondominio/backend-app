import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/select_apt_service.dart';

import 'api.dart';

class SelectAptAPI extends Api {
  final SelectAptService _service;
  SelectAptAPI(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/teste', (Request req) async {
      String? body = req.url.queryParameters['id'];
      final user = await _service.findUser(int.parse(body!));
      final residents = await _service.findResidents(user.id!);
      List<Map> resultado = [];
      if (residents.isNotEmpty) {
        for (final resident in residents) {
          final condo = await _service.findCondo(resident.idCondo!);
          resultado.add({
            'userName': user.name,
            'condoName': condo.name,
            'zipCode': condo.zipCode,
            'idCondo': condo.id,
            'idResident': resident.id,
            'city': null,
            'uf': null,
            'apt': resident.apartament,
            'opt': resident.optApartament
          });
        }
      } else {
        resultado.add({'userName': user.name});
      }
      return Response(200, body: jsonEncode(resultado));
    });

    return createHandler(router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}

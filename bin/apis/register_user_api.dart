import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterUserApi extends Api {
  final GenericService<UserModel> _service;
  RegisterUserApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(UserModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/user', (Request req) async {
      List<UserModel> registers = await _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

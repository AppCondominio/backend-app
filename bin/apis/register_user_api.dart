import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/register_user_service.dart';
import 'api.dart';

class RegisterUserApi extends Api {
  final RegisterUserService _service;
  RegisterUserApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(UserModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.get('/user/all', (Request req) async {
      List<UserModel> registers = await _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    router.get('/user', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var user = await _service.findOne(int.parse(id));
      if (user == null) return Response(404);
      return Response.ok(jsonEncode(user.toJson()));
    });

    router.get('/user/info', (Request req) async {
      String? uid = req.url.queryParameters['uid'];
      if (uid == null) return Response(400);
      var user = await _service.findByUid(uid);
      if (user == null) return Response(404);
      return Response.ok(jsonEncode(user.toJson()));
    });

    router.get('/user/document', (Request req) async {
      String? id = req.url.queryParameters['document'];
      if (id == null) return Response(400);
      var user = await _service.findByDocument(id);
      if (user == null) return Response(404);
      return Response.ok(jsonEncode(user.toJson()));
    });

    router.get('/user/search', (Request req) async {
      String? id = req.url.queryParameters['document'];
      if (id == null) return Response(400);
      var user = await _service.findByDocumentSearch(id);
      if (user == null) return Response(404);
      return Response.ok(jsonEncode(user.toJson()));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

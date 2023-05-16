import 'dart:convert';

import 'package:commons_core/commons_core.dart';
import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';
import 'package:stripe/stripe.dart';

import '../models/condo_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class RegisterCondoApi extends Api {
  final GenericService<CondoModel> _service;

  RegisterCondoApi(this._service);

  Future<bool?> getStatusAssinatura(String? idCustomer) async {
    if (idCustomer == null) return null;
    final apiKey = await CustomEnv.get<String>(key: 'stripe_key');
    final stripe = Stripe(apiKey);

    final subscriptionList = await stripe.subscription.list(ListSubscriptionsRequest(
      customer: idCustomer,
      status: SubscriptionStatus.active,
    ));

    if (subscriptionList.data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/condo', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var condo = CondoModel.fromRequest(jsonDecode(body));
      var result = await _service.save(condo);
      return result ? Response(201) : Response(500);
    });

    router.get('/condo/payment', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var statusAssinatura = await getStatusAssinatura(id);
      if (statusAssinatura != null) {
        if (statusAssinatura) return Response(200);
        return Response(400);
      }
      return Response(404);
    });

    router.get('/condo/all', (Request req) async {
      List<CondoModel> registers = await _service.findAll();
      List<Map> registerMap = registers.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(registerMap));
    });

    router.get('/condo', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var condo = await _service.findOne(int.parse(id));
      if (condo == null) return Response(404);
      return Response.ok(jsonEncode(condo.toJson()));
    });

    router.put('/condo', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var result = await _service.save(CondoModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    router.delete('/condo', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}

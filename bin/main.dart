import 'package:shelf/shelf.dart';

import 'apis/condo_api.dart';
import 'apis/cooperator_api.dart';
import 'apis/login_api.dart';
import 'apis/recreation_api.dart';
import 'apis/register_condo_api.dart';
import 'apis/register_resident_api.dart';
import 'apis/register_user_api.dart';
import 'apis/warning_api.dart';
import 'infra/custom_server.dart';
import 'package:commons_core/commons_core.dart';

import 'infra/injects.dart';
import 'infra/middleware_interception.dart';

void main() async {
  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<RegisterUserApi>().getHandler())
      .add(_di.get<RegisterCondoApi>().getHandler())
      .add(_di.get<CondoApi>().getHandler())
      .add(_di.get<RecreationApi>().getHandler())
      .add(_di.get<CooperatorApi>().getHandler())
      .add(_di.get<RegisterResidentApi>().getHandler())
      .add(_di.get<WarningApi>().getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}

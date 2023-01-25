import 'package:shelf/shelf.dart';

import 'apis/login_api.dart';
import 'apis/register_api.dart';
import 'infra/custom_server.dart';
import 'package:commons_core/commons_core.dart';

import 'infra/injects.dart';
import 'infra/middleware_interception.dart';

void main() async {
  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<RegisterApi>().getHandler())
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

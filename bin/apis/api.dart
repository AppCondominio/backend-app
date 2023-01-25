import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    var pipe = Pipeline();
    for (var m in middlewares) {
      pipe = pipe.addMiddleware(m);
    }
    return pipe.addHandler(router);
  }
}

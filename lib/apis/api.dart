import 'package:shelf/shelf.dart';
import 'package:test_backend/infra/dependency_injector/dependency_injector.dart';
import 'package:test_backend/infra/security/security_service.dart';

abstract class Api {
  Handler getHendler({List<Middleware>? middlewares, bool isSecurity = false});
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];
    final securityService = DependencyInjector().get<SecurityService>();

    if (isSecurity == true) {
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJwt,
      ]);
    }

    var pipeline = Pipeline();
    for (var m in middlewares) {
      pipeline = pipeline.addMiddleware(m);
    }

    return pipeline.addHandler(router);
  }
}

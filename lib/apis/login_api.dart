import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test_backend/apis/api.dart';
import 'package:test_backend/infra/security/security_service.dart';

class LoginApi extends Api {
  final SecurityService _securityService;

  LoginApi(this._securityService);

  @override
  Handler getHendler({List<Middleware>? middlewares}) {
    Router router = Router();
    router.post('/login', (Request request) async {
      final token = await _securityService.generateJWT('01');
      return Response.ok(jsonEncode({"token": token}));
    });
    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}

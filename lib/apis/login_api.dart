import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test_backend/apis/api.dart';
import 'package:test_backend/infra/security/security_service.dart';
import 'package:test_backend/services/login_service.dart';
import 'package:test_backend/to/auth_to.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHendler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.post('/login', (Request request) async {
      var body = await request.readAsString();
      final authTO = AuthTO.fromRequest(body);

      final userID = await _loginService.authenticate(authTO);
      if (userID > 0) {
        final jwt = await _securityService.generateJWT(userID.toString());
        return Response.ok(jsonEncode({"token": jwt}));
      } else {
        return Response(401);
      }
    });
    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}

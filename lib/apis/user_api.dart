import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test_backend/apis/api.dart';
import 'package:test_backend/models/user_model.dart';
import 'package:test_backend/services/user_service.dart';

class UserApi extends Api {
  final UserService _userService;

  UserApi(this._userService);
  @override
  Handler getHendler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/user', (Request req) async {
      final bodyJson = await req.readAsString();
      if (bodyJson.isEmpty) return Response.badRequest();
      final user = UserModel.fromRequest(jsonDecode(bodyJson));
      final result = await _userService.save(user);
      return result ? Response(201) : Response(500);
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
    );
  }
}

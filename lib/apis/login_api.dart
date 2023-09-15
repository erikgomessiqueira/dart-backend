import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  static Handler handler() {
    Router router = Router();
    router.post('/login', (Request request) {
      return Response.ok('ApiLogin');
    });
    return router;
  }
}

import 'package:shelf/shelf.dart';
import 'package:test_backend/apis/blog_api.dart';
import 'package:test_backend/apis/login_api.dart';
import 'package:test_backend/infra/custom_server.dart';
import 'package:test_backend/infra/middleware_interception.dart';
import 'package:test_backend/infra/security/security_service_impl.dart';
import 'package:test_backend/services/notice_service.dart';
import 'package:test_backend/utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env');

  final _securityService = SecurityServiceImpl();

  final cascadeHandlers = Cascade()
      .add(LoginApi(_securityService).getHendler(
        middlewares: [
          createMiddleware(requestHandler: (Request req) {
            print('Log -> ${req.url}');
          }),
        ],
      ))
      .add(BlogApi(NoticeService()).handler)
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddleInterception().middleware)
      .addMiddleware(_securityService.authorization)
      .addMiddleware(_securityService.verifyJwt)
      .addHandler(cascadeHandlers);

  await CustomServer.initialize(
    handler: handler,
    address: await CustomEnv.get<String>('serverAddress'),
    port: await CustomEnv.get<int>('serverPort'),
  );
}

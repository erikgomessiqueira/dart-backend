import 'package:shelf/shelf.dart';
import 'package:test_backend/apis/blog_api.dart';
import 'package:test_backend/apis/login_api.dart';
import 'package:test_backend/dao/user_dao.dart';
import 'package:test_backend/infra/custom_server.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/infra/dependency_injector/injects.dart';
import 'package:test_backend/infra/middleware_interception.dart';
import 'package:test_backend/utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env');

  final di = Injects.initialize();

  final dbConfiguration = await di<DBConfiguration>();
  final _userDAO = UserDAO(dbConfiguration);

  final cascadeHandlers = Cascade()
      .add(di.get<LoginApi>().getHendler())
      .add(di.get<BlogApi>().getHendler(isSecurity: true))
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddleInterception().middleware)
      .addHandler(cascadeHandlers);

  await CustomServer.initialize(
    handler: handler,
    address: await CustomEnv.get<String>('serverAddress'),
    port: await CustomEnv.get<int>('serverPort'),
  );
}

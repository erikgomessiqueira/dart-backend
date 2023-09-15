import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test_backend/apis/blog_api.dart';
import 'package:test_backend/apis/login_api.dart';
import 'package:test_backend/infra/custom_server.dart';
import 'package:test_backend/utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env');
  final cascadeHandlers =
      Cascade().add(LoginApi.handler()).add(BlogApi.handler()).handler;

  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandlers);

  await CustomServer.initialize(
    handler: handler,
    address: await CustomEnv.get<String>('serverAddress'),
    port: await CustomEnv.get<int>('serverPort'),
  );
}

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test_backend/apis/api.dart';
import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';

class NoticesApi extends Api {
  final GenericService<NoticeModel> _service;

  NoticesApi(
    this._service,
  );

  @override
  Handler getHendler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/noticias', (Request request) async {
      final notices = await _service.findAll();
      List<Map> noticesMap = notices.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticesMap));
    });

    router.post('/noticias', (Request request) async {
      final bodyJson = await request.readAsString();
      final result =
          await _service.save(NoticeModel.fromRequest(jsonDecode(bodyJson)));
      return result ? Response(201) : Response.internalServerError();
    });

    ///QueryParams = [id]
    router.put('/noticias', (Request request) async {
      final bodyJson = await request.readAsString();
      final result = await _service.save(
        NoticeModel.fromRequest(jsonDecode(bodyJson)),
      );
      return result ? Response(201) : Response.internalServerError();
    });

    ///QueryParams = [id]
    router.delete('/noticias', (Request request) async {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      final result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}

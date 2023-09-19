import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test_backend/apis/api.dart';
import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';

class BlogApi extends Api {
  final GenericService<NoticeModel> _service;

  BlogApi(
    this._service,
  );

  @override
  Handler getHendler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/blog/noticias', (Request request) {
      final notices = _service.findAll();
      List<Map> noticesMap = notices.map((e) => e.toJson()).toList();
      return Response.ok(
        jsonEncode(noticesMap),
      );
    });

    router.post('/blog/noticias', (Request request) async {
      final bodyJson = await request.readAsString();
      _service.save(NoticeModel.fromJson(jsonDecode(bodyJson)));
      return Response(201);
    });

    ///QueryParams = [id]
    router.put('/blog/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response.notFound('Noticia nao encontrada');
      // _service.save('');
      return Response.ok('Noticia atualizada');
    });

    ///QueryParams = [id]
    router.delete('/blog/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response.notFound('Noticia nao encontrada');
      _service.delete(1);
      return Response.ok('Noticia deletada');
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}

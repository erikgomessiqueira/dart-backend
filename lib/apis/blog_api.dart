import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  static Handler handler() {
    Router router = Router();

    router.get('/blog/noticia', (Request request) {
      return Response.ok('Noticias');
    });

    router.post('/blog/noticia', (Request request) {
      return Response.ok('Noticia adicionada');
    });

    ///QueryParams = [id]
    router.put('/blog/noticia', (Request request) {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response.notFound('Noticia nao encontrada');
      return Response.ok('Noticia atualizada');
    });

    ///QueryParams = [id]
    router.delete('/blog/noticia', (Request request) {
      String? id = request.url.queryParameters['id'];
      if (id == null) return Response.notFound('Noticia nao encontrada');
      return Response.ok('Noticia deletada');
    });

    return router;
  }
}

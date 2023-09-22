import 'package:shelf/shelf.dart';

class MInterception {
  static Middleware get contentTypeJson {
    return createMiddleware(
      responseHandler: (Response res) {
        return res.change(headers: {'content-type': 'application/json'});
      },
    );
  }

  static Middleware get cors {
    final acceptedHeaders = {'Access-Control-Allow-Origin': '*'};

    Response? handlerOptions(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: acceptedHeaders);
      } else {
        return null;
      }
    }

    Response addCorsHeader(Response res) {
      return res.change(headers: acceptedHeaders);
    }

    return createMiddleware(
      requestHandler: handlerOptions,
      responseHandler: addCorsHeader,
    );
  }
}

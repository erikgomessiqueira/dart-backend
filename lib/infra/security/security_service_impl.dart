import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:test_backend/infra/security/security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:test_backend/infra/security/validate/api_router_validate.dart';
import 'package:test_backend/utils/custom_env.dart';

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userId) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userId': userId,
      'roules': ['admin', 'user']
    });

    String key = await CustomEnv.get('jwtKey');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  validateJWT(String token) async {
    String key = await CustomEnv.get('jwtKey');

    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException catch (_) {
      return null;
    } on JWTExpiredException catch (_) {
      return null;
    } on JWTNotActiveException catch (_) {
      return null;
    } on JWTUndefinedException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        final authorizationHeader = req.headers['Authorization'];
        JWT? jwt;
        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            final token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        final request = req.change(
          context: {
            'jwt': jwt,
          },
        );
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request req) {
          ApiRouterValidate _apiSecurity = ApiRouterValidate()
              .add('login')
              .add('xpto')
              .add('register')
              .add('teste');

          if (_apiSecurity.isPublic(req.url.path)) return null;
          if (req.context['jwt'] == null) {
            return Response.forbidden(
              jsonEncode({
                'error': 'Token inválido',
                'message': 'Usuário não autorizado.'
              }),
            );
          }
          return null;
        },
      );
}

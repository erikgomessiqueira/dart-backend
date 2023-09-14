import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  try {
    final serve = await shelf_io.serve(
        (request) => Response(200, body: 'Status: ATIVO'), 'localhost', 8080);

    print('Servidor iniciado em http://localhost:8080');
  } catch (e) {
    print('Erro ao iniciar o servidor!');
  }
}

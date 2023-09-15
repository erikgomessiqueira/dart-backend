import 'package:intl/intl.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  static Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    final hourInit = DateFormat('HH:m:ss').format(DateTime.now());

    await shelf_io.serve(handler, address, port);
    print("\x1b[2j\x1b[0;0h");
    print('Servidor iniciado as $hourInit em http://$address:$port');
  }
}

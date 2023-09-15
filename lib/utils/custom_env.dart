import 'dart:io';
import 'parser_extention.dart';

class CustomEnv {
  static Map<String, String> _map = {};
  static String _file = '.env';
  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static Future<T> get<T>(String key) async {
    if (_map.isEmpty) await _load();
    return _map[key]!.toType(T);
  }

  static Future<void> _load() async {
    List<String> rows =
        (await _readFile()).replaceAll(String.fromCharCode(13), "").split('\n');
    _map = {
      for (var r in rows) r.split('=')[0]: r.split('=')[1],
    };
  }

  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}

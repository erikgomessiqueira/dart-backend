import 'package:mysql1/mysql1.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/utils/custom_env.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;
  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConection();

    if (_connection == null) {
      throw Exception('[ERROR_DB] -> Falha ao criar conexão.');
    }

    return _connection!;
  }

  @override
  Future<MySqlConnection> createConection() async {
    return MySqlConnection.connect(ConnectionSettings(
      host: '127.0.0.1', //await CustomEnv.get<String>('dbHost'),
      port: 3306, //await CustomEnv.get<int>('dbPort'),
      user: 'dart_user', //await CustomEnv.get<String>('dbUser'),
      password: 'dart_pass', //await CustomEnv.get<String>('dbPassword'),
      db: 'dart', //await CustomEnv.get<String>('dbSchema'),
    ));
  }

  @override
  execQuery(String sql, [List? params]) async {
    final connection = await this.connection;
    final Results results = await connection.query(sql, params);
    return results;
  }
}

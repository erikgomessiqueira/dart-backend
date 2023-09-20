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
      host: await CustomEnv.get<String>('dbHost'),
      port: await CustomEnv.get<int>('dbPort'),
      user: await CustomEnv.get<String>('dbUser'),
      password: await CustomEnv.get<String>('dbPassword'),
      db: await CustomEnv.get<String>('dbSchema'),
    ));
  }
}

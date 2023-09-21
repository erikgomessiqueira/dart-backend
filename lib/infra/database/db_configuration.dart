abstract class DBConfiguration {
  Future<dynamic> createConection();
  Future<dynamic> get connection;
  execQuery(String sql, [List? params]);
}

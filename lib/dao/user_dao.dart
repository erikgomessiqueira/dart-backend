import 'package:mysql1/mysql1.dart';
import 'package:test_backend/dao/dao.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/models/user_model.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future create(UserModel value) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> findAll() async {
    final String sql = 'SELECT * FROM usuarios';
    final connection = await _dbConfiguration.connection;
    final Results results = await connection.query(sql);
    return results.map((e) => UserModel.fromMap(e.fields)).toList();
  }

  @override
  Future<UserModel> findOne(int id) async {
    final String sql = 'SELECT * FROM usuarios WHERE id = ?';
    final connection = await _dbConfiguration.connection;
    final Results results = await connection.query(sql, [id]);
    if (results.isEmpty) {
      throw Exception('[ERRO_DB] -> findOne for id: $id, not found');
    }
    return UserModel.fromMap(results.first.fields);
  }

  @override
  Future update(UserModel value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}

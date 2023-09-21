import 'package:mysql1/mysql1.dart';
import 'package:test_backend/dao/dao.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/models/user_model.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future<bool> create(UserModel value) async {
    final Results results = await _dbConfiguration.execQuery(
      'INSERT INTO usuarios( nome, email, password) VALUES (?, ?, ?)',
      [value.name, value.email, value.password],
    );
    return results.affectedRows != null && results.affectedRows! > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final Results results = await _dbConfiguration
        .execQuery('DELETE FROM usuarios where id= ? ', [id]);
    return results.affectedRows != null && results.affectedRows! > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final Results results =
        await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    return results
        .map((e) => UserModel.fromMap(e.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    final Results results = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);
    return results.isEmpty ? null : UserModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(UserModel user) async {
    final Results results = await _dbConfiguration.execQuery(
      'UPDATE usuarios SET nome = ?, password = ? WHERE id = ?;',
      [user.name, user.password, user.id],
    );
    return results.affectedRows != null && results.affectedRows! > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    final Results results = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE email = ?', [email]);
    return results.isEmpty ? null : UserModel.fromEmail(results.first.fields);
  }
}

import 'package:mysql1/mysql1.dart';
import 'package:test_backend/dao/dao.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/models/notice_model.dart';

class NoticeDAO implements DAO<NoticeModel> {
  final DBConfiguration _dbConfiguration;
  NoticeDAO(this._dbConfiguration);

  @override
  Future<bool> create(NoticeModel value) async {
    final Results results = await _dbConfiguration.execQuery(
      'INSERT INTO noticias (titulo, descricao, id_usuario) VALUES (?, ?, ?)',
      [value.title, value.description, value.userId],
    );
    return results.affectedRows != null && results.affectedRows! > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final Results results = await _dbConfiguration
        .execQuery('DELETE FROM noticias where id= ? ', [id]);
    return results.affectedRows != null && results.affectedRows! > 0;
  }

  @override
  Future<List<NoticeModel>> findAll() async {
    final Results results =
        await _dbConfiguration.execQuery('SELECT * FROM noticias');
    return results
        .map((e) => NoticeModel.fromMap(e.fields))
        .toList()
        .cast<NoticeModel>();
  }

  @override
  Future<NoticeModel?> findOne(int id) async {
    final Results results = await _dbConfiguration
        .execQuery('SELECT * FROM noticias WHERE id = ?', [id]);
    return results.isEmpty ? null : NoticeModel.fromMap(results.first.fields);
  }

  @override
  Future<bool> update(NoticeModel notice) async {
    final Results results = await _dbConfiguration.execQuery(
      'UPDATE noticias SET titulo = ?, descricao = ? WHERE id = ?',
      [notice.title, notice.description, notice.id],
    );
    return results.affectedRows != null && results.affectedRows! > 0;
  }
}

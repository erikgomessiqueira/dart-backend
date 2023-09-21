import 'package:test_backend/dao/notice_dao.dart';
import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';
import '../utils/list_extension.dart';

class NoticeService implements GenericService<NoticeModel> {
  final NoticeDAO _noticeDAO;

  NoticeService(this._noticeDAO);
  @override
  Future<bool> delete(int id) async => _noticeDAO.delete(id);

  @override
  Future<List<NoticeModel>> findAll() async {
    return _noticeDAO.findAll();
  }

  @override
  Future<NoticeModel?> findOne(int id) async {
    return _noticeDAO.findOne(id);
  }

  @override
  Future<bool> save(NoticeModel value) async {
    if (value.id != null) {
      return _noticeDAO.update(value);
    } else {
      return _noticeDAO.create(value);
    }
  }
}

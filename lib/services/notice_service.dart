import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';
import '../utils/list_extension.dart';

class NoticeService implements GenericService<NoticeModel> {
  final List<NoticeModel> _fakeDb = [];
  @override
  bool delete(int id) {
    _fakeDb.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<NoticeModel> findAll() {
    return _fakeDb;
  }

  @override
  NoticeModel findOne(int id) {
    return _fakeDb.firstWhere((e) => e.id == id);
  }

  @override
  bool save(NoticeModel value) {
    NoticeModel? model = _fakeDb.firstWhereOrNull((e) => e.id == value.id);

    if (model == null) {
      _fakeDb.add(value);
    } else {
      final index = _fakeDb.indexOf(model);
      _fakeDb[index] = value;
    }

    return true;
  }
}

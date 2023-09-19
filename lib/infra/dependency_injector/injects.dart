import 'package:test_backend/apis/blog_api.dart';
import 'package:test_backend/apis/login_api.dart';
import 'package:test_backend/infra/dependency_injector/dependency_injector.dart';
import 'package:test_backend/infra/security/security_service.dart';
import 'package:test_backend/infra/security/security_service_impl.dart';
import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';
import 'package:test_backend/services/notice_service.dart';

class Injects {
  static DependencyInjector initialize() {
    final di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImpl());

    di.register<LoginApi>(() => LoginApi(di()));

    di.register<GenericService<NoticeModel>>(() => NoticeService());
    di.register<BlogApi>(() => BlogApi(di()));

    return di;
  }
}

import 'package:test_backend/apis/notices_api.dart';
import 'package:test_backend/apis/login_api.dart';
import 'package:test_backend/apis/user_api.dart';
import 'package:test_backend/dao/notice_dao.dart';
import 'package:test_backend/dao/user_dao.dart';
import 'package:test_backend/infra/database/db_configuration.dart';
import 'package:test_backend/infra/database/mysql_db_configuration.dart';
import 'package:test_backend/infra/dependency_injector/dependency_injector.dart';
import 'package:test_backend/infra/security/security_service.dart';
import 'package:test_backend/infra/security/security_service_impl.dart';
import 'package:test_backend/models/notice_model.dart';
import 'package:test_backend/services/generic_service.dart';
import 'package:test_backend/services/login_service.dart';
import 'package:test_backend/services/notice_service.dart';
import 'package:test_backend/services/user_service.dart';

class Injects {
  static DependencyInjector initialize() {
    final di = DependencyInjector();

    //Database
    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    //Security
    di.register<SecurityService>(() => SecurityServiceImpl());

    //User
    di.register<UserDAO>(() => UserDAO(di<DBConfiguration>()));
    di.register<UserService>(() => UserService(di<UserDAO>()));
    di.register<UserApi>(() => UserApi(di<UserService>()));

    //Login
    di.register<LoginService>(() => LoginService(di<UserService>()));
    di.register<LoginApi>(
      () => LoginApi(di<SecurityService>(), di<LoginService>()),
    );

    //Blog
    di.register<NoticeDAO>(() => NoticeDAO(di<DBConfiguration>()));
    di.register<NoticeService>(() => NoticeService(di<NoticeDAO>()));
    di.register<GenericService<NoticeModel>>(() => di<NoticeService>());
    di.register<NoticesApi>(
      () => NoticesApi(di<GenericService<NoticeModel>>()),
    );

    return di;
  }
}

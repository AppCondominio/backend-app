import 'package:commons_core/commons_core.dart';

import '../apis/login_api.dart';
import '../apis/register_api.dart';
import '../models/user_model.dart';
import '../services/generic_service.dart';
import '../services/register_service.dart';
import 'security/security_service.dart';
import 'security/security_service_imp.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<GenericService<UserModel>>(() => RegisterService());
    di.register<RegisterApi>(() => RegisterApi(di.get(), di.get()));

    di.register<LoginApi>(() => LoginApi(di.get(), di.get()));

    return di;
  }
}

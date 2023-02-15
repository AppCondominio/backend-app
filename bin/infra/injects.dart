import 'package:commons_core/commons_core.dart';

import '../apis/condo_api.dart';
import '../apis/cooperator_api.dart';
import '../apis/login_api.dart';
import '../apis/recreation_api.dart';
import '../apis/register_condo_api.dart';
import '../apis/register_resident_api.dart';
import '../apis/register_user_api.dart';
import '../models/condo_model.dart';
import '../models/condo_settings_model.dart';
import '../models/cooperator_model.dart';
import '../models/recreation_model.dart';
import '../models/resident_model.dart';
import '../models/user_model.dart';
import '../services/condo_settings_service.dart';
import '../services/cooperator_service.dart';
import '../services/generic_service.dart';
import '../services/recreation_service.dart';
import '../services/register_condo_service.dart';
import '../services/register_resident_service.dart';
import '../services/register_user_service.dart';
import 'security/security_service.dart';
import 'security/security_service_imp.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<GenericService<UserModel>>(() => RegisterUserService());
    di.register<RegisterUserApi>(() => RegisterUserApi(di.get(), di.get()));

    di.register<GenericService<CondoModel>>(() => RegisterCondoService());
    di.register<RegisterCondoApi>(() => RegisterCondoApi(di.get()));

    di.register<GenericService<ResidentModel>>(() => RegisterResidentService());
    di.register<RegisterResidentApi>(
        () => RegisterResidentApi(di.get()));

    di.register<GenericService<CondoSettingsModel>>(
        () => CondoSettingsService());
    di.register<CondoApi>(() => CondoApi(di.get()));

    di.register<GenericService<RecreationModel>>(() => RecreationService());
    di.register<RecreationApi>(() => RecreationApi(di.get()));

    di.register<GenericService<CooperatorModel>>(() => CooperatorService());
    di.register<CooperatorApi>(() => CooperatorApi(di.get()));

    di.register<LoginApi>(() => LoginApi(di.get(), di.get(), di.get()));

    return di;
  }
}

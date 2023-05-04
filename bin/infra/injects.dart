import 'package:commons_core/commons_core.dart';

import '../apis/complaint_api.dart';
import '../apis/condo_settings_api.dart';
import '../apis/cooperator_api.dart';
import '../apis/login_api.dart';
import '../apis/recreation_api.dart';
import '../apis/register_condo_api.dart';
import '../apis/register_resident_api.dart';
import '../apis/register_user_api.dart';
import '../apis/reminder_api.dart';
import '../apis/select_apt_api.dart';
import '../apis/tower_settings_api.dart';
import '../apis/notice_api.dart';
import '../dao/complaint_dao.dart';
import '../dao/condo_dao.dart';
import '../dao/cooperator_settings_dao.dart';
import '../dao/notice_dao.dart';
import '../dao/recreation_settings_dao.dart';
import '../dao/reminder_dao.dart';
import '../dao/resident_dao.dart';
import '../dao/select_apt_dao.dart';
import '../dao/settings_condo_dao.dart';

import '../dao/tower_settings_dao.dart';
import '../dao/user_dao.dart';
import '../models/condo_model.dart';
import '../services/complaint_service.dart';
import '../services/condo_settings_service.dart';
import '../services/cooperator_service.dart';
import '../services/generic_service.dart';
import '../services/login_service.dart';
import '../services/recreation_service.dart';
import '../services/register_condo_service.dart';
import '../services/register_resident_service.dart';
import '../services/register_user_service.dart';
import '../services/reminder_service.dart';
import '../services/select_apt_service.dart';
import '../services/tower_settings_service.dart';
import '../services/notice_service.dart';
import 'database/db_configuration.dart';
import 'database/mysql_db_configuration.dart';
import 'security/security_service.dart';
import 'security/security_service_imp.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    di.register<SecurityService>(() => SecurityServiceImp());

    // Condiminio
    di.register<CondoDAO>(() => CondoDAO(di<DBConfiguration>()));
    di.register<GenericService<CondoModel>>(() => RegisterCondoService(di<CondoDAO>()));
    di.register<RegisterCondoApi>(() => RegisterCondoApi(di<GenericService<CondoModel>>()));

    // Usuario
    di.register<UserDAO>(() => UserDAO(di<DBConfiguration>()));
    di.register<RegisterUserService>(() => RegisterUserService(di<UserDAO>()));
    di.register<RegisterUserApi>(() => RegisterUserApi(di<RegisterUserService>()));

    // Login
    di.register<LoginService>(() => LoginService(di<GenericService<CondoModel>>(), di<RegisterUserService>()));
    di.register<LoginApi>(() => LoginApi(di<LoginService>()));

    // Residentes
    di.register<ResidentDAO>(() => ResidentDAO(di<DBConfiguration>()));
    di.register<RegisterResidentService>(() => RegisterResidentService(di<ResidentDAO>()));
    di.register<RegisterResidentApi>(() => RegisterResidentApi(di<RegisterResidentService>()));

    // Configuracoes Condominio
    di.register<SettingsCondoDAO>(() => SettingsCondoDAO(di<DBConfiguration>()));
    di.register<CondoSettingsService>(() => CondoSettingsService(di<SettingsCondoDAO>()));
    di.register<CondoSettingsApi>(() => CondoSettingsApi(di<CondoSettingsService>()));

    // Configuracoes Condominio (Torres/Blocos)
    di.register<TowerSettingDAO>(() => TowerSettingDAO(di<DBConfiguration>()));
    di.register<TowerSettingService>(() => TowerSettingService(di<TowerSettingDAO>()));
    di.register<TowerSettingsApi>(() => TowerSettingsApi(di<TowerSettingService>()));

    // Configuracoes Condominio (Area de lazer)
    di.register<RecreationSettingDAO>(() => RecreationSettingDAO(di<DBConfiguration>()));
    di.register<RecreationService>(() => RecreationService(di<RecreationSettingDAO>()));
    di.register<RecreationApi>(() => RecreationApi(di<RecreationService>()));

    // Configuracoes Condominio (Colaboradores)
    di.register<CooperatorSettingsDAO>(() => CooperatorSettingsDAO(di<DBConfiguration>()));
    di.register<CooperatorService>(() => CooperatorService(di<CooperatorSettingsDAO>()));
    di.register<CooperatorApi>(() => CooperatorApi(di<CooperatorService>()));

    // Avisos
    di.register<NoticeDAO>(() => NoticeDAO(di<DBConfiguration>()));
    di.register<NoticeService>(() => NoticeService(di<NoticeDAO>()));
    di.register<NoticeApi>(() => NoticeApi(di<NoticeService>()));

    // Ocorrencias
    di.register<ComplaintDAO>(() => ComplaintDAO(di<DBConfiguration>()));
    di.register<ComplaintService>(() => ComplaintService(di<ComplaintDAO>()));
    di.register<ComplaintApi>(() => ComplaintApi(di<ComplaintService>()));

    // Feature -> Usuario selecionar condomínios cadastrados
    di.register<SelectAptDAO>(() => SelectAptDAO(di<DBConfiguration>()));
    di.register<SelectAptService>(() => SelectAptService(di<SelectAptDAO>()));
    di.register<SelectAptAPI>(() => SelectAptAPI(di<SelectAptService>()));

    // Lembretes para os condomínios
    di.register<ReminderDAO>(() => ReminderDAO(di<DBConfiguration>()));
    di.register<ReminderService>(() => ReminderService(di<ReminderDAO>()));
    di.register<ReminderApi>(() => ReminderApi(di<ReminderService>()));

    return di;
  }
}

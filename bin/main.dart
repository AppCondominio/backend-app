// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'apis/calendar_api.dart';
import 'apis/complaint_api.dart';
import 'apis/condo_settings_api.dart';
import 'apis/cooperator_api.dart';
import 'apis/login_api.dart';
import 'apis/recreation_api.dart';
import 'apis/register_condo_api.dart';
import 'apis/register_resident_api.dart';
import 'apis/register_user_api.dart';
import 'apis/reminder_api.dart';
import 'apis/select_apt_api.dart';
import 'apis/tower_settings_api.dart';
import 'apis/notice_api.dart';
import 'infra/custom_server.dart';
import 'package:commons_core/commons_core.dart';

import 'infra/injects.dart';
import 'infra/middleware_interception.dart';

void main() async {
  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<RegisterUserApi>().getHandler())
      .add(_di.get<RegisterCondoApi>().getHandler())
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<CondoSettingsApi>().getHandler())
      .add(_di.get<RegisterResidentApi>().getHandler())
      .add(_di.get<TowerSettingsApi>().getHandler())
      .add(_di.get<RecreationApi>().getHandler())
      .add(_di.get<CooperatorApi>().getHandler())
      .add(_di.get<NoticeApi>().getHandler())
      .add(_di.get<ComplaintApi>().getHandler())
      .add(_di.get<SelectAptAPI>().getHandler())
      .add(_di.get<ReminderApi>().getHandler())
      .add(_di.get<CalendarApi>().getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(corsHeaders())
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}

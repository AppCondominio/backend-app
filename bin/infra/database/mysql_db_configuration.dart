import 'package:commons_core/commons_core.dart';
import 'package:mysql_client/mysql_client.dart';

import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySQLConnection? _connection;

  @override
  Future<MySQLConnection> get connection async {
    _connection ??= await createConection();
    if (_connection == null) throw Exception('[ERROR-DB] -> Failed create connection');
    return _connection!;
  }

  @override
  Future<MySQLConnection> createConection() async {
    return await MySQLConnection.createConnection(
      host: await CustomEnv.get<String>(key: 'db_host'),
      port: await CustomEnv.get<int>(key: 'db_port'),
      userName: await CustomEnv.get<String>(key: 'db_user'),
      password: await CustomEnv.get<String>(key: 'db_pass'),
      databaseName: await CustomEnv.get<String>(key: 'db_schema'),
    );
  }
}

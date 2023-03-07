import '../infra/database/db_configuration.dart';
import '../models/condo_model.dart';
import 'dao.dart';

class CondoDAO implements DAO<CondoModel> {
  final DBConfiguration _dbConfiguration;
  CondoDAO(this._dbConfiguration);

  @override
  Future<bool> create(CondoModel value) async {
    var result = await _execQuery(
        'INSERT INTO tb_condo (name,document,password,email,zipCode,addressNumber) VALUES (:name,:document,:password,:email,:zipCode,:addressNumber)',
        {
          'name': value.name,
          'document': value.document,
          'password': value.password,
          'email': value.email,
          'zipCode': value.zipCode,
          'addressNumber': value.addressNumber,
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _execQuery('DELETE FROM tb_condo WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<CondoModel>> findAll() async {
    var result = await _execQuery('SELECT * FROM tb_condo');
    return result.rows.map((r) => CondoModel.fromMap(r.assoc())).toList().cast<CondoModel>();
  }

  @override
  Future<CondoModel?> findOne(int id) async {
    var result = await _execQuery('SELECT * FROM tb_condo WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : CondoModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(CondoModel value) async {
    var result = await _execQuery(
      'UPDATE tb_condo SET name = :name, password = :password WHERE id = :id',
      {'name': value.name, 'password': value.password, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  _execQuery(String sql, [Map<String, dynamic>? params]) async {
    var conn = await _dbConfiguration.connection;
    await conn.connect();
    var result = await conn.execute(sql, params);
    await conn.close();
    return result;
  }
}

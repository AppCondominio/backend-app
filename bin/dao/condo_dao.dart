import '../infra/database/db_configuration.dart';
import '../models/condo_model.dart';
import 'dao.dart';

class CondoDAO implements DAO<CondoModel> {
  final DBConfiguration _dbConfiguration;
  CondoDAO(this._dbConfiguration);

  @override
  Future<bool> create(CondoModel value) async {
    var result = await _dbConfiguration.execQuery(
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
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_condo WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<CondoModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_condo');
    return result.rows.map((r) => CondoModel.fromMap(r.assoc())).toList().cast<CondoModel>();
  }

  @override
  Future<CondoModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_condo WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : CondoModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(CondoModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_condo SET name = :name, password = :password, dtUpdated = :dtUpdated WHERE id = :id',
      {'name': value.name, 'password': value.password,'dtUpdated' : DateTime.now(),'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<CondoModel?> findByDocument(String document) async {
    var r = await _dbConfiguration.execQuery('SELECT * FROM tb_condo WHERE document = :document', {'document': document});
    return r.rows.isEmpty ? null : CondoModel.fromDocument(r.rows.first.assoc());
  }
}

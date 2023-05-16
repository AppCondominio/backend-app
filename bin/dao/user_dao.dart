import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);


   @override
  Future<bool> create(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
        'INSERT INTO tb_user (name,lastName,document,password,email,phone,deviceToken) VALUES (:name,:lastName,:document,:password,:email,:phone,:deviceToken)',
        {
          'name': value.name,
          'lastName': value.lastName,
          'document': value.document,
          'password': value.password,
          'email': value.email,
          'phone': value.phone,
          'deviceToken': value.deviceToken,
        });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_user WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_user');
    return result.rows.map((r) => UserModel.fromMap(r.assoc())).toList().cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_user WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : UserModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_user SET email = :email, phone = :phone WHERE id = :id',
      {'email': value.email, 'phone': value.phone, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<bool> updatePassword(UserModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_user SET password = :password WHERE id = :id',
      {'password': value.password, 'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<UserModel?> findByDocument(String document) async {
    var r = await _dbConfiguration.execQuery('SELECT * FROM tb_user WHERE document = :document', {'document': document});
    return r.rows.isEmpty ? null : UserModel.fromDocument(r.rows.first.assoc());
  }

  Future<UserModel?> findByDocumentSearch(String document) async {
    var r = await _dbConfiguration.execQuery('SELECT * FROM tb_user WHERE document = :document', {'document': document});
    return r.rows.isEmpty ? null : UserModel.fromMap(r.rows.first.assoc());
  }
}

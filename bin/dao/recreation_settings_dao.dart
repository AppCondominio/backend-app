import 'dart:convert';

import '../infra/database/db_configuration.dart';
import '../models/recreation_model.dart';
import 'dao.dart';

class RecreationSettingDAO implements DAO<RecreationModel> {
  final DBConfiguration _dbConfiguration;
  RecreationSettingDAO(this._dbConfiguration);

  @override
  Future<bool> create(RecreationModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO tb_recreation_settings (name, price, availability, idSettingCondo, policyDocument, description) VALUES (:name, :price, :availability, :idSettingCondo, :policyDocument, :description)',
      {
        'name': value.name,
        'price': value.price,
        'availability': jsonEncode(value.availability),
        'idSettingCondo': value.idSettingCondo,
        'policyDocument': value.policyDocument,
        'description': value.description
      });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery('DELETE FROM tb_recreation_settings WHERE id = :id', {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<RecreationModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_recreation_settings');
    return result.rows.map((r) => RecreationModel.fromMap(r.assoc())).toList().cast<RecreationModel>();
  }

  @override
  Future<RecreationModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM tb_recreation_settings WHERE id = :id', {'id': id});
    return result.rows.isEmpty ? null : RecreationModel.fromMap(result.rows.first.assoc());
  }

  @override
  Future<bool> update(RecreationModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE tb_recreation_settings SET name = :name, price = :price, availability = :availability, dtUpdated = :dtUpdated, policyDocument = :policyDocument, description = :description WHERE id = :id',
      {'name': value.name, 'price': value.price, 'availability': jsonEncode(value.availability), 'dtUpdated': DateTime.now(), 'policyDocument': value.policyDocument,'description':value.description ,'id': value.id},
    );
    return result.affectedRows.toInt() > 0;
  }

  Future<List<RecreationModel>> findAllBySetting(int idSettingCondo) async {
    var result =
        await _dbConfiguration.execQuery('SELECT * FROM tb_recreation_settings WHERE idSettingCondo = :idSettingCondo', {'idSettingCondo': idSettingCondo});
    return result.rows.map((r) => RecreationModel.fromMap(r.assoc())).toList().cast<RecreationModel>();
  }
}

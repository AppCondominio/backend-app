import 'package:commons_core/commons_core.dart';
import 'package:password_dart/password_dart.dart';
import 'package:stripe/stripe.dart';

import '../dao/condo_dao.dart';
import '../models/condo_model.dart';
import 'generic_service.dart';

class RegisterCondoService implements GenericService<CondoModel> {
  final CondoDAO _condoDAO;
  RegisterCondoService(this._condoDAO);

  @override
  Future<bool> delete(int id) async => await _condoDAO.delete(id);

  @override
  Future<List<CondoModel>> findAll() async => await _condoDAO.findAll();

  @override
  Future<CondoModel?> findOne(int id) async => await _condoDAO.findOne(id);

  @override
  Future<bool> save(CondoModel value) async {
    if (value.id != null) {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;
      return await _condoDAO.update(value);
    } else {
      return await _condoDAO.create(value);
    }
  }

  Future<CondoModel?> findByUid(String uid) async => await _condoDAO.findByUid(uid);

  Future<CondoModel?> findByDocument(String document) async => await _condoDAO.findByDocument(document);
}

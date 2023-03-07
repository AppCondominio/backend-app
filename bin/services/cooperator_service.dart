import '../models/cooperator_model.dart';
import 'generic_service.dart';

class CooperatorService implements GenericService<CooperatorModel> {
  final List<CooperatorModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<CooperatorModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<CooperatorModel?> findOne(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(CooperatorModel value) async {
    _fakeDB.add(value);
    return true;
  }
}

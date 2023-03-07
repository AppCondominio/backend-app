import '../models/resident_model.dart';
import 'generic_service.dart';

class RegisterResidentService implements GenericService<ResidentModel> {
  final List<ResidentModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<ResidentModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<ResidentModel?> findOne(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(ResidentModel value) async {
    _fakeDB.add(value);
    return true;
  }
}

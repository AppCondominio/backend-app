import '../models/resident_model.dart';
import 'generic_service.dart';

class RegisterResidentService implements GenericService<ResidentModel> {
  final List<ResidentModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<ResidentModel> findAll() {
    return _fakeDB;
  }

  @override
  ResidentModel findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(ResidentModel value) {
      _fakeDB.add(value);
    return true;
  }
}

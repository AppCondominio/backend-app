import '../models/recreation_model.dart';
import 'generic_service.dart';

class RecreationService implements GenericService<RecreationModel> {
  final List<RecreationModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<RecreationModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<RecreationModel?> findOne(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(RecreationModel value) async{
    _fakeDB.add(value);
    return true;
  }
}

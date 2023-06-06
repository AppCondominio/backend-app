import '../dao/reminder_dao.dart';
import '../models/reminder_model.dart';
import 'generic_service.dart';

class ReminderService implements GenericService<ReminderModel> {
  final ReminderDAO _reminderDAO;
  ReminderService(this._reminderDAO);

  @override
  Future<bool> delete(int id) async => await _reminderDAO.delete(id);

  @override
  Future<List<ReminderModel>> findAll() async => await _reminderDAO.findAll();

  @override
  Future<ReminderModel?> findOne(int id) async => await _reminderDAO.findOne(id);

  @override
  Future<bool> save(ReminderModel value) async {
    if (value.id != null) {
      return await _reminderDAO.update(value);
    } else {
      return await _reminderDAO.create(value);
    }
  }

  Future<List<ReminderModel>> findAllByIdCondo(int idCondo) async => await _reminderDAO.findAllByIdCondo(idCondo);
}

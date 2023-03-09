import '../dao/notice_dao.dart';
import '../models/notice_model.dart';
import 'generic_service.dart';

class NoticeService implements GenericService<NoticeModel> {
  final NoticeDAO _noticeDAO;
  NoticeService(this._noticeDAO);

  @override
  Future<bool> delete(int id) async => _noticeDAO.delete(id);

  @override
  Future<List<NoticeModel>> findAll() async => _noticeDAO.findAll();

  @override
  Future<NoticeModel?> findOne(int id) async => await _noticeDAO.findOne(id);

  @override
  Future<bool> save(NoticeModel value) async {
    if (value.id != null) {
      return await _noticeDAO.update(value);
    } else {
      return await _noticeDAO.create(value);
    }
  }

  Future<List<NoticeModel>> findAllByIdCondo(int idCondo) async => _noticeDAO.findAllByIdCondo(idCondo);
}

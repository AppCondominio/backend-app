import 'package:intl/intl.dart';

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

  Future<List<NoticeModel>> findAllByIdCondo(int idCondo, {String? status}) async {
    List<NoticeModel> notices;
    status != null ? notices = await _noticeDAO.findAllByStatus(idCondo, status) : notices = await _noticeDAO.findAllByIdCondo(idCondo);

    DateTime? dtToDeleteTD;
    DateTime today = DateTime.now();
    for (var notice in notices) {
      dtToDeleteTD = DateTime.tryParse(notice.dtToDelete!);
      Duration diference = dtToDeleteTD!.difference(today);
      notice.leftDays = diference.inDays;
      notice.dtToDelete = DateFormat('dd/MM/yyyy').format(dtToDeleteTD);
    }
    return notices;
  }
}

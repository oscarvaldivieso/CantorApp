import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:cantor_app/features/hojitas/domain/hojita_repository.dart';
import 'hojita_isar_dao.dart';

class HojitaRepositoryImpl implements HojitaRepository {
  final HojitaIsarDao _dao;

  HojitaRepositoryImpl(this._dao);

  @override
  Future<List<Hojita>> getAll() => _dao.getAll();

  @override
  Stream<List<Hojita>> watchAll() => _dao.watchAll();

  @override
  Future<Hojita?> getById(int id) => _dao.getById(id);

  @override
  Future<Hojita?> getByUuid(String uuid) async {
    final all = await _dao.getAll();
    try {
      return all.firstWhere((h) => h.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> save(Hojita hojita) => _dao.save(hojita);

  @override
  Future<bool> delete(int id) => _dao.delete(id);
}

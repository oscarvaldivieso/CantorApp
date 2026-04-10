import 'package:cantor_app/core/database/isar_service.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';

class HojitaIsarDao {
  final IsarService _isarService;

  HojitaIsarDao(this._isarService);

  Stream<List<Hojita>> watchAll() => _isarService.watchAllHojitas();
  Future<List<Hojita>> getAll() => _isarService.getAllHojitas();
  Future<Hojita?> getById(int id) => _isarService.getHojitaById(id);
  Future<int> save(Hojita hojita) => _isarService.saveHojita(hojita);
  Future<bool> delete(int id) => _isarService.deleteHojita(id);
}

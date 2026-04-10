import 'package:cantor_app/core/database/isar_service.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';

class CantoIsarDao {
  final IsarService _isarService;

  CantoIsarDao(this._isarService);

  Stream<List<Canto>> watchAll() => _isarService.watchAllCantos();
  Future<List<Canto>> getAll() => _isarService.getAllCantos();
  Future<Canto?> getById(int id) => _isarService.getCantoById(id);
  Future<Canto?> getByUuid(String uuid) => _isarService.getCantoByUuid(uuid);
  Future<List<Canto>> search(String query) => _isarService.searchCantos(query);
  Future<List<Canto>> getByCategoria(String cat) =>
      _isarService.getCantosByCategoria(cat);
  Future<int> save(Canto canto) => _isarService.saveCanto(canto);
  Future<bool> delete(int id) => _isarService.deleteCanto(id);
}

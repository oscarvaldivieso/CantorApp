import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cantor_app/core/database/isar_service.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final cantosStreamProvider = StreamProvider<List<Canto>>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return isar.watchAllCantos();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoriaProvider = StateProvider<String?>((ref) => null);

final cantosFilteredProvider = Provider<AsyncValue<List<Canto>>>((ref) {
  final cantosAsync = ref.watch(cantosStreamProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final categoria = ref.watch(selectedCategoriaProvider);

  return cantosAsync.whenData((cantos) {
    var filtered = cantos;

    if (query.isNotEmpty) {
      filtered = filtered.where((c) {
        return c.titulo.toLowerCase().contains(query) ||
            (c.autor?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (categoria != null && categoria.isNotEmpty) {
      filtered = filtered.where((c) {
        return c.categorias.contains(categoria);
      }).toList();
    }

    return filtered;
  });
});

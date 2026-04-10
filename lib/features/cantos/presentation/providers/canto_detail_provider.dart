import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'cantos_provider.dart';

final cantoDetailProvider =
    FutureProvider.family<Canto?, int>((ref, id) async {
  final isar = ref.watch(isarServiceProvider);
  return isar.getCantoById(id);
});

final selectedTonalityProvider =
    StateProvider.family<String?, int>((ref, cantoId) => null);

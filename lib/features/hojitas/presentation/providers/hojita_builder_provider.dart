import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita.dart';
import 'package:cantor_app/features/hojitas/domain/hojita_item.dart';

class HojitaBuilderState {
  final String titulo;
  final DateTime fecha;
  final String tipoMisa;
  final String parroquiaNombre;
  final String template;
  final List<HojitaItem> cantos;
  final int currentStep;
  final String? notas;

  const HojitaBuilderState({
    this.titulo = '',
    DateTime? fecha,
    this.tipoMisa = 'dominical',
    this.parroquiaNombre = '',
    this.template = 'clasico',
    this.cantos = const [],
    this.currentStep = 0,
    this.notas,
  }) : fecha = fecha ?? const _DefaultDate();

  HojitaBuilderState copyWith({
    String? titulo,
    DateTime? fecha,
    String? tipoMisa,
    String? parroquiaNombre,
    String? template,
    List<HojitaItem>? cantos,
    int? currentStep,
    String? notas,
  }) {
    return HojitaBuilderState(
      titulo: titulo ?? this.titulo,
      fecha: fecha ?? this.fecha,
      tipoMisa: tipoMisa ?? this.tipoMisa,
      parroquiaNombre: parroquiaNombre ?? this.parroquiaNombre,
      template: template ?? this.template,
      cantos: cantos ?? this.cantos,
      currentStep: currentStep ?? this.currentStep,
      notas: notas ?? this.notas,
    );
  }
}

// Workaround for default DateTime in const constructor
class _DefaultDate implements DateTime {
  const _DefaultDate();

  DateTime get _now => DateTime.now();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      Function.apply(
        () => _now,
        [],
      ).noSuchMethod(invocation);
}

class HojitaBuilderNotifier extends StateNotifier<HojitaBuilderState> {
  final IsarServiceRef _ref;

  HojitaBuilderNotifier(this._ref) : super(HojitaBuilderState(fecha: DateTime.now()));

  void setTitulo(String v) => state = state.copyWith(titulo: v);
  void setFecha(DateTime v) => state = state.copyWith(fecha: v);
  void setTipoMisa(String v) => state = state.copyWith(tipoMisa: v);
  void setParroquiaNombre(String v) => state = state.copyWith(parroquiaNombre: v);
  void setTemplate(String v) => state = state.copyWith(template: v);
  void setNotas(String v) => state = state.copyWith(notas: v);
  void setStep(int v) => state = state.copyWith(currentStep: v);

  void addCanto(HojitaItem item) {
    final cantos = [...state.cantos, item..orden = state.cantos.length];
    state = state.copyWith(cantos: cantos);
  }

  void removeCanto(String cantoUuid) {
    final cantos = state.cantos.where((c) => c.cantoUuid != cantoUuid).toList();
    for (var i = 0; i < cantos.length; i++) {
      cantos[i].orden = i;
    }
    state = state.copyWith(cantos: cantos);
  }

  void reorderCantos(int oldIndex, int newIndex) {
    final cantos = [...state.cantos];
    if (newIndex > oldIndex) newIndex--;
    final item = cantos.removeAt(oldIndex);
    cantos.insert(newIndex, item);
    for (var i = 0; i < cantos.length; i++) {
      cantos[i].orden = i;
    }
    state = state.copyWith(cantos: cantos);
  }

  bool isCantoSelected(String cantoUuid) {
    return state.cantos.any((c) => c.cantoUuid == cantoUuid);
  }

  Future<int> save() async {
    final isar = _ref.read(isarServiceProvider);
    final now = DateTime.now();
    final hojita = Hojita()
      ..uuid = const Uuid().v4()
      ..titulo = state.titulo.isEmpty ? 'Hojita ${now.day}/${now.month}/${now.year}' : state.titulo
      ..fecha = state.fecha
      ..tipoMisa = state.tipoMisa
      ..parroquiaNombre = state.parroquiaNombre.isEmpty ? null : state.parroquiaNombre
      ..cantos = state.cantos
      ..template = state.template
      ..notas = state.notas
      ..creadoEn = now
      ..actualizadoEn = now;
    return isar.saveHojita(hojita);
  }

  void reset() {
    state = HojitaBuilderState(fecha: DateTime.now());
  }
}

typedef IsarServiceRef = Ref;

final hojitaBuilderProvider =
    StateNotifierProvider<HojitaBuilderNotifier, HojitaBuilderState>((ref) {
  return HojitaBuilderNotifier(ref);
});

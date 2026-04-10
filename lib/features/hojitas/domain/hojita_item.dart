import 'package:isar/isar.dart';

part 'hojita_item.g.dart';

@embedded
class HojitaItem {
  late String cantoUuid;
  late String cantoTitulo;
  late String cantoAutor;
  late String cantoCategoria;
  int orden = 0;
  String? tonalidad;
  String? notaDirector;
  bool incluirAcordes = false;
}

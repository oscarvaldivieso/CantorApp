class LiturgicalCalendar {
  LiturgicalCalendar._();

  /// Devuelve el tiempo litúrgico aproximado según la fecha.
  /// Esta es una aproximación simplificada; el calendario litúrgico real
  /// depende de la fecha de Pascua cada año.
  static String tiempoActual([DateTime? fecha]) {
    final now = fecha ?? DateTime.now();
    final year = now.year;

    // Calcular Pascua con el algoritmo de Butcher
    final pascua = _calcularPascua(year);

    // Miércoles de Ceniza: 46 días antes de Pascua
    final ceniza = pascua.subtract(const Duration(days: 46));
    // Domingo de Ramos: 7 días antes de Pascua
    final ramos = pascua.subtract(const Duration(days: 7));
    // Pentecostés: 49 días después de Pascua
    final pentecostes = pascua.add(const Duration(days: 49));

    // Adviento: 4 domingos antes de Navidad (aprox 3 dic)
    final navidad = DateTime(year, 12, 25);
    final diasHastaNavidad = navidad.weekday % 7;
    final primerAdviento =
        navidad.subtract(Duration(days: 21 + diasHastaNavidad + 7));

    // Epifanía: 6 de enero del siguiente año (o del actual si estamos en enero)
    final epifania = DateTime(year, 1, 6);
    final epifaniaSig = DateTime(year + 1, 1, 6);

    if (now.isBefore(epifania) || now.isAtSameMomentAs(epifania)) {
      return 'navidad';
    }
    if (now.isBefore(ceniza)) {
      return 'ordinario';
    }
    if (now.isBefore(ramos)) {
      return 'cuaresma';
    }
    if (now.isBefore(pascua) || now.isAtSameMomentAs(pascua)) {
      return 'semanaSanta';
    }
    if (now.isBefore(pentecostes) || now.isAtSameMomentAs(pentecostes)) {
      return 'pascua';
    }
    if (now.isBefore(primerAdviento)) {
      return 'ordinario';
    }
    if (now.isBefore(navidad)) {
      return 'adviento';
    }
    if (now.isBefore(epifaniaSig) || now.isAtSameMomentAs(epifaniaSig)) {
      return 'navidad';
    }
    return 'ordinario';
  }

  /// Algoritmo de Butcher para calcular la fecha de Pascua.
  static DateTime _calcularPascua(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }
}

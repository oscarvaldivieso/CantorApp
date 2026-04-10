enum Categoria {
  entrada,
  gloria,
  salmo,
  aleluya,
  ofertorio,
  santo,
  memorial,
  comunion,
  accionGracias,
  salida,
  adoracion,
  varios;

  String get label {
    switch (this) {
      case entrada:
        return 'Entrada';
      case gloria:
        return 'Gloria';
      case salmo:
        return 'Salmo';
      case aleluya:
        return 'Aleluya';
      case ofertorio:
        return 'Ofertorio';
      case santo:
        return 'Santo';
      case memorial:
        return 'Memorial';
      case comunion:
        return 'Comunión';
      case accionGracias:
        return 'Acción de Gracias';
      case salida:
        return 'Salida';
      case adoracion:
        return 'Adoración';
      case varios:
        return 'Varios';
    }
  }

  String get emoji {
    switch (this) {
      case entrada:
        return '🚪';
      case gloria:
        return '✨';
      case salmo:
        return '📖';
      case aleluya:
        return '🎵';
      case ofertorio:
        return '🍞';
      case santo:
        return '🔔';
      case memorial:
        return '🕯️';
      case comunion:
        return '🍷';
      case accionGracias:
        return '🙏';
      case salida:
        return '🚶';
      case adoracion:
        return '⛪';
      case varios:
        return '📋';
    }
  }
}

enum TiempoLiturgico {
  adviento,
  navidad,
  cuaresma,
  semanaSanta,
  pascua,
  pentecostes,
  ordinario,
  todos;

  String get label {
    switch (this) {
      case adviento:
        return 'Adviento';
      case navidad:
        return 'Navidad';
      case cuaresma:
        return 'Cuaresma';
      case semanaSanta:
        return 'Semana Santa';
      case pascua:
        return 'Pascua';
      case pentecostes:
        return 'Pentecostés';
      case ordinario:
        return 'Tiempo Ordinario';
      case todos:
        return 'Todos';
    }
  }
}

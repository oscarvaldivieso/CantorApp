# CantorApp – Cantoral Digital Católico 🎵

Aplicación móvil Android desarrollada en Flutter que funciona como un cantoral digital católico. Permite consultar 30 cantos litúrgicos, transponer tonalidades, y crear **hojitas de misa** en PDF para compartir.

---

## Características principales

| Funcionalidad | Descripción |
|---|---|
| **Catálogo de cantos** | 30 cantos pre-cargados con letra, acordes ChordPro y metadatos litúrgicos |
| **Transposición** | Cambia la tonalidad de cualquier canto en tiempo real (12 semitonos) |
| **Hojitas de misa** | Crea hojas de cantos para una celebración, con reorden drag-and-drop |
| **Exportación PDF** | Genera PDF con diseño editorial (cabecera azul marino, acentos dorados) |
| **Compartir** | Comparte hojitas en PDF a WhatsApp, correo, etc. |
| **Calendario litúrgico** | Detecta automáticamente el Tiempo Litúrgico actual |
| **Diseño editorial** | Paleta inspirada en libros litúrgicos: azul marino, dorado, crema |

---

## Estructura del proyecto

```
lib/
├── main.dart                         # Punto de entrada
├── app.dart                          # MaterialApp.router
├── core/
│   ├── theme/                        # Colores, tipografía, tema global
│   ├── utils/                        # Transpositor de acordes, calendario litúrgico
│   ├── database/                     # Isar service + datos semilla (30 cantos)
│   └── router/                       # GoRouter con ShellRoute
├── features/
│   ├── home/                         # Pantalla de inicio / dashboard
│   ├── cantos/                       # Catálogo, detalle y editor de cantos
│   │   ├── domain/                   # Modelo Isar + enums + repositorio
│   │   ├── data/                     # DAO + implementación de repositorio
│   │   └── presentation/            # Páginas, providers y widgets
│   └── hojitas/                      # Constructor y preview de hojitas de misa
│       ├── domain/
│       ├── data/                     # DAO + repositorio + generador PDF
│       └── presentation/
└── shared/
    └── widgets/                      # Scaffold, chips litúrgicos, badges, empty state
```

---

## Requisitos

- **Flutter SDK** ≥ 3.22.0
- **Dart SDK** ≥ 3.4.0
- **Android SDK** con API 21+ (Android 5.0 Lollipop o superior)
- Un emulador Android o dispositivo físico conectado

---

## Instalación y ejecución

```bash
# 1. Clonar el repositorio
git clone <url-del-repo>
cd CantorApp

# 2. Instalar dependencias
flutter pub get

# 3. Generar archivos de Isar (schemas)
dart run build_runner build --delete-conflicting-outputs

# 4. Verificar que no haya errores
dart analyze lib

# 5. Ejecutar en un emulador o dispositivo conectado
flutter run
```

### Compilar APK de debug

```bash
flutter build apk --debug
```

El APK resultante estará en `build/app/outputs/flutter-apk/app-debug.apk`.

---

## Stack tecnológico

| Paquete | Versión | Uso |
|---|---|---|
| `flutter_riverpod` | ^2.5.1 | Estado global reactivo |
| `hooks_riverpod` | ^2.5.1 | Hooks + Riverpod |
| `go_router` | ^14.2.0 | Navegación declarativa con ShellRoute |
| `isar` | ^3.1.0 | Base de datos local NoSQL |
| `pdf` | ^3.11.0 | Generación de documentos PDF |
| `printing` | ^5.13.0 | Vista previa e impresión de PDF |
| `share_plus` | ^10.0.0 | Compartir archivos |
| `google_fonts` | ^6.2.1 | Playfair Display + Crimson Pro |
| `intl` | ^0.19.0 | Formato de fechas en español |

---

## Navegación

La app utiliza navegación con barra inferior (3 pestañas):

1. **🏠 Inicio** – Dashboard con Tiempo Litúrgico, estadísticas rápidas, accesos directos
2. **🎵 Cantos** – Lista filtrable por categoría con búsqueda, acceso a detalle con acordes
3. **📋 Hojitas** – Lista de hojitas creadas, botón para crear nueva (stepper de 3 pasos)

---

## Licencia

Proyecto académico. Los textos de los cantos incluidos son versiones de referencia con contenido simplificado.
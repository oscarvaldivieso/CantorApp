# SUPUESTOS.md – Decisiones de diseño y supuestos

Este documento lista las decisiones técnicas y de contenido tomadas durante el desarrollo de CantorApp.

---

## 1. Contenido de los cantos

- Los 30 cantos pre-cargados incluyen **títulos y autores reales** del repertorio litúrgico católico hispano (e.g., "Pescador de Hombres" de Cesáreo Gabaráin, "Alabaré" tradicional).
- Las **letras son versiones simplificadas de referencia**, no transcripciones textuales completas, para evitar problemas de derechos de autor.
- Los **acordes ChordPro** son aproximaciones funcionales para demostrar la transposición; no son transcripciones profesionales verificadas.

## 2. Calendario litúrgico

- La detección del Tiempo Litúrgico usa el **algoritmo de Butcher** para calcular la fecha de Pascua y derivar los demás tiempos (Adviento, Navidad, Cuaresma, Pascua, Ordinario).
- Es una **aproximación algorítmica**, no una consulta al Ordo oficial de ninguna diócesis. No contempla fiestas de precepto, solemnidades trasladadas ni variaciones regionales.
- Adviento se calcula como los 4 domingos antes de Navidad; Navidad va del 25/12 al 6/01; Cuaresma comienza el Miércoles de Ceniza (46 días antes de Pascua); Pascua dura 50 días hasta Pentecostés.

## 3. Base de datos

- Se utiliza **Isar 3.1.0** como base de datos local embedida (NoSQL). Fue elegida por su rendimiento, soporte de streams reactivos y generación de código.
- Los esquemas se generan con `build_runner` e `isar_generator`.
- La base de datos se inicializa en `main.dart` y se siembra automáticamente con los 30 cantos al primer inicio.

## 4. Arquitectura

- Se aplica **Feature-First Clean Architecture** con tres capas por feature: `domain/`, `data/`, `presentation/`.
- El estado global se maneja con **Riverpod** (flutter_riverpod + hooks_riverpod).
- La navegación usa **GoRouter** con `ShellRoute` para la barra inferior (Home, Cantos, Hojitas) y rutas independientes para detalle, editor y preview.

## 5. Generación de PDF

- Los PDFs se generan con el paquete `pdf` de Dart, no con plantillas HTML.
- El diseño incluye cabecera azul marino con título y fecha, lista numerada de cantos con autor, y pie de página.
- Se soportan 4 "plantillas" visuales (Clásica, Moderna, Minimalista, Festiva) que varían colores y tipografía.
- Los PDFs se guardan temporalmente en el directorio de la aplicación antes de compartirlos.

## 6. Compartir

- Se usa `share_plus ^10.0.0` con la API `Share.shareXFiles()` para compartir archivos PDF.
- La funcionalidad depende del sistema de compartir nativo de Android (share sheet).

## 7. Tipografía

- Se utilizan **Google Fonts**: `Playfair Display` para encabezados y `Crimson Pro` para cuerpo de texto.
- Estas fuentes se descargan en tiempo de ejecución vía el paquete `google_fonts`. Se requiere conexión a internet en la primera ejecución para cachearlas.

## 8. Transposición de acordes

- El transpositor soporta los 12 semitonos cromáticos estándar.
- Los bemoles (♭) se normalizan a sus equivalentes sostenidos (♯) para simplificar: D♭→C♯, E♭→D♯, G♭→F♯, A♭→G♯, B♭→A♯.
- Soporta acordes con bajo (e.g., `C/G`), menores (`Am`), séptimas (`G7`), y sus combinaciones.

## 9. Plataforma objetivo

- La app está configurada exclusivamente para **Android** (minSdkVersion 21, API 5.0 Lollipop).
- No se ha probado ni configurado para iOS, web ni escritorio.

## 10. Idioma

- Toda la interfaz de usuario está en **español**.
- No se implementó internacionalización (i18n) multi-idioma; los strings están hardcodeados en español.

## 11. Tema y diseño visual

- La paleta de colores está inspirada en **libros litúrgicos tradicionales**: azul marino profundo (#1B2A4A), dorado (#C9A84C), crema (#FDF6E3).
- Los colores litúrgicos (morado, blanco, verde, rojo, rosa) se corresponden con los tiempos del año litúrgico.
- El diseño busca un estilo **editorial/eclesiástico**, no un Material Design genérico.

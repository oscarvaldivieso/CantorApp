import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CantoEditorPage extends HookConsumerWidget {
  const CantoEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tituloCtrl = useTextEditingController();
    final autorCtrl = useTextEditingController();
    final letraCtrl = useTextEditingController();
    final acordesCtrl = useTextEditingController();
    final tonalidadCtrl = useTextEditingController();
    final selectedCategorias = useState<List<String>>([]);
    final selectedTiempos = useState<List<String>>([]);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navyDeep,
        title: Text(
          'Nuevo Canto',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          icon: Text(
            '← Volver',
            style: GoogleFonts.crimsonPro(
              fontSize: 13,
              color: AppColors.gold,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            TextField(
              controller: tituloCtrl,
              style: GoogleFonts.crimsonPro(fontSize: 16),
              decoration: const InputDecoration(labelText: 'Título del canto'),
            ),
            const SizedBox(height: 16),

            // Author
            TextField(
              controller: autorCtrl,
              style: GoogleFonts.crimsonPro(fontSize: 16),
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
            const SizedBox(height: 16),

            // Tonalidad
            TextField(
              controller: tonalidadCtrl,
              style: GoogleFonts.crimsonPro(fontSize: 16),
              decoration: const InputDecoration(
                labelText: 'Tonalidad',
                hintText: 'Ej: G, Am, F#',
              ),
            ),
            const SizedBox(height: 20),

            // Categorías
            Text(
              'CATEGORÍAS',
              style: GoogleFonts.crimsonPro(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Categoria.values.map((cat) {
                final selected = selectedCategorias.value.contains(cat.name);
                return FilterChip(
                  label: Text(cat.label),
                  selected: selected,
                  onSelected: (v) {
                    final list = [...selectedCategorias.value];
                    v ? list.add(cat.name) : list.remove(cat.name);
                    selectedCategorias.value = list;
                  },
                  selectedColor: AppColors.navyDeep,
                  labelStyle: GoogleFonts.crimsonPro(
                    color: selected ? AppColors.white : AppColors.textMuted,
                  ),
                  checkmarkColor: AppColors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Tiempos litúrgicos
            Text(
              'TIEMPOS LITÚRGICOS',
              style: GoogleFonts.crimsonPro(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TiempoLiturgico.values.map((t) {
                final selected = selectedTiempos.value.contains(t.name);
                return FilterChip(
                  label: Text(t.label),
                  selected: selected,
                  onSelected: (v) {
                    final list = [...selectedTiempos.value];
                    v ? list.add(t.name) : list.remove(t.name);
                    selectedTiempos.value = list;
                  },
                  selectedColor: AppColors.navyDeep,
                  labelStyle: GoogleFonts.crimsonPro(
                    color: selected ? AppColors.white : AppColors.textMuted,
                  ),
                  checkmarkColor: AppColors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Letra
            TextField(
              controller: letraCtrl,
              style: GoogleFonts.crimsonPro(fontSize: 16),
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Letra',
                hintText: 'Usa {C} para coro, {E1} para estrofa 1, etc.',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),

            // Acordes
            TextField(
              controller: acordesCtrl,
              style: GoogleFonts.crimsonPro(fontSize: 16),
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Acordes (ChordPro)',
                hintText: '[G]Señor ten [Am]piedad...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),

            // Save button
            ElevatedButton(
              onPressed: () async {
                if (tituloCtrl.text.isEmpty || letraCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Título y letra son obligatorios'),
                    ),
                  );
                  return;
                }
                final now = DateTime.now();
                final canto = Canto()
                  ..uuid = const Uuid().v4()
                  ..titulo = tituloCtrl.text.trim()
                  ..autor = autorCtrl.text.trim()
                  ..letra = letraCtrl.text
                  ..acordes = acordesCtrl.text.isEmpty
                      ? null
                      : acordesCtrl.text
                  ..tonalidad = tonalidadCtrl.text.isEmpty
                      ? null
                      : tonalidadCtrl.text.trim()
                  ..categorias = selectedCategorias.value.isEmpty
                      ? ['varios']
                      : selectedCategorias.value
                  ..tiempos = selectedTiempos.value.isEmpty
                      ? ['todos']
                      : selectedTiempos.value
                  ..esLocal = true
                  ..esGlobal = false
                  ..creadoEn = now
                  ..actualizadoEn = now;

                final isar = ref.read(isarServiceProvider);
                await isar.saveCanto(canto);

                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Canto guardado')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navyDeep,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Guardar Canto',
                style: GoogleFonts.crimsonPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

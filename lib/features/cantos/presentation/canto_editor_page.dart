import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:uuid/uuid.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Nuevo Canto',
          style: AppTypography.serif(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tituloCtrl,
              style: AppTypography.sans(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              decoration: const InputDecoration(
                  labelText: 'Título del canto'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: autorCtrl,
              style: AppTypography.sans(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              decoration:
                  const InputDecoration(labelText: 'Autor'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tonalidadCtrl,
              style: AppTypography.sans(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              decoration: const InputDecoration(
                labelText: 'Tonalidad',
                hintText: 'Ej: G, Am, F#',
              ),
            ),
            const SizedBox(height: 24),

            // Categorías
            Text('CATEGORÍAS', style: AppTypography.sectionLabel),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Categoria.values.map((cat) {
                final selected =
                    selectedCategorias.value.contains(cat.name);
                return FilterChip(
                  label: Text(cat.label),
                  selected: selected,
                  onSelected: (v) {
                    final list = [...selectedCategorias.value];
                    v
                        ? list.add(cat.name)
                        : list.remove(cat.name);
                    selectedCategorias.value = list;
                  },
                  selectedColor: activeColor,
                  labelStyle: AppTypography.sans(
                    fontSize: 13,
                    color: selected
                        ? (isDark
                            ? AppColors.darkBg
                            : AppColors.white)
                        : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                  ),
                  checkmarkColor:
                      isDark ? AppColors.darkBg : AppColors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Tiempos litúrgicos
            Text('TIEMPOS LITÚRGICOS',
                style: AppTypography.sectionLabel),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TiempoLiturgico.values.map((t) {
                final selected =
                    selectedTiempos.value.contains(t.name);
                return FilterChip(
                  label: Text(t.label),
                  selected: selected,
                  onSelected: (v) {
                    final list = [...selectedTiempos.value];
                    v
                        ? list.add(t.name)
                        : list.remove(t.name);
                    selectedTiempos.value = list;
                  },
                  selectedColor: activeColor,
                  labelStyle: AppTypography.sans(
                    fontSize: 13,
                    color: selected
                        ? (isDark
                            ? AppColors.darkBg
                            : AppColors.white)
                        : (isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                  ),
                  checkmarkColor:
                      isDark ? AppColors.darkBg : AppColors.white,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Letra
            TextField(
              controller: letraCtrl,
              style: AppTypography.sans(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Letra',
                hintText:
                    'Usa {C} para coro, {E1} para estrofa 1, etc.',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),

            // Acordes
            TextField(
              controller: acordesCtrl,
              style: AppTypography.mono(fontSize: 14),
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Acordes (ChordPro)',
                hintText: '[G]Señor ten [Am]piedad...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),

            // Save button
            GestureDetector(
              onTap: () async {
                if (tituloCtrl.text.isEmpty ||
                    letraCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Título y letra son obligatorios'),
                    ),
                  );
                  return;
                }
                HapticFeedback.mediumImpact();
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
                    const SnackBar(
                        content: Text('Canto guardado')),
                  );
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Guardar Canto',
                    style: AppTypography.sans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojita_builder_provider.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/canto_selector_sheet.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/pdf_template_selector.dart';

class HojitaBuilderPage extends HookConsumerWidget {
  const HojitaBuilderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.watch(hojitaBuilderProvider);
    final notifier = ref.read(hojitaBuilderProvider.notifier);
    final tituloCtrl = useTextEditingController(text: builder.titulo);
    final parroquiaCtrl =
        useTextEditingController(text: builder.parroquiaNombre);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final steps = ['Info', 'Cantos', 'Ordenar'];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Nueva Hojita',
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
          onPressed: () {
            notifier.reset();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // ─── Stepper ───
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: isDark
                ? AppColors.darkBgSecondary
                : AppColors.surfaceElevated,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (i) {
                final isActive = builder.currentStep == i;
                final isDone = builder.currentStep > i;
                final activeColor = isDark
                    ? AppColors.goldLuminous
                    : AppColors.goldDeep;
                return Row(
                  children: [
                    if (i > 0)
                      Container(
                        width: 32,
                        height: 2,
                        color: isDone
                            ? activeColor
                            : (isDark
                                ? AppColors.darkTextSecondary
                                    .withValues(alpha: 0.2)
                                : AppColors.textSecondary
                                    .withValues(alpha: 0.15)),
                      ),
                    GestureDetector(
                      onTap: () {
                        if (isDone || isActive) notifier.setStep(i);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? activeColor
                                  : isDone
                                      ? activeColor.withValues(
                                          alpha: 0.2)
                                      : Colors.transparent,
                              border: Border.all(
                                color: isActive || isDone
                                    ? activeColor
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                            .withValues(alpha: 0.3)
                                        : AppColors.textSecondary
                                            .withValues(alpha: 0.2)),
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: isDone
                                ? Icon(Icons.check,
                                    color: activeColor, size: 16)
                                : Text(
                                    '${i + 1}',
                                    style: AppTypography.sans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: isActive
                                          ? (isDark
                                              ? AppColors.darkBg
                                              : AppColors.white)
                                          : (isDark
                                              ? AppColors
                                                  .darkTextSecondary
                                              : AppColors
                                                  .textSecondary),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[i],
                            style: AppTypography.sans(
                              fontSize: 11,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isActive
                                  ? activeColor
                                  : (isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          // ─── Content ───
          Expanded(
            child: IndexedStack(
              index: builder.currentStep,
              children: [
                _Step1Info(
                  tituloCtrl: tituloCtrl,
                  parroquiaCtrl: parroquiaCtrl,
                  builder: builder,
                  notifier: notifier,
                ),
                _Step2Cantos(builder: builder, notifier: notifier),
                _Step3Reorder(builder: builder, notifier: notifier),
              ],
            ),
          ),

          // ─── Bottom Navigation ───
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBgSecondary
                  : AppColors.surfaceElevated,
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color:
                            AppColors.warmShadow.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -3),
                      ),
                    ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  if (builder.currentStep > 0)
                    TextButton(
                      onPressed: () =>
                          notifier.setStep(builder.currentStep - 1),
                      child: Text(
                        '← Anterior',
                        style: AppTypography.sans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (builder.currentStep < 2)
                    GestureDetector(
                      onTap: () {
                        notifier.setTitulo(tituloCtrl.text);
                        notifier.setParroquiaNombre(parroquiaCtrl.text);
                        notifier.setStep(builder.currentStep + 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.goldGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: (isDark
                                      ? AppColors.goldLuminous
                                      : AppColors.goldDeep)
                                  .withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'Siguiente →',
                          style: AppTypography.sans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  if (builder.currentStep == 2)
                    GestureDetector(
                      onTap: builder.cantos.isEmpty
                          ? null
                          : () async {
                              HapticFeedback.mediumImpact();
                              notifier.setTitulo(tituloCtrl.text);
                              notifier
                                  .setParroquiaNombre(parroquiaCtrl.text);
                              final id = await notifier.save();
                              if (context.mounted) {
                                notifier.reset();
                                context.go('/hojitas/$id/preview');
                              }
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: builder.cantos.isEmpty
                              ? null
                              : AppColors.goldGradient,
                          color: builder.cantos.isEmpty
                              ? (isDark
                                  ? AppColors.darkTextSecondary
                                      .withValues(alpha: 0.2)
                                  : AppColors.textSecondary
                                      .withValues(alpha: 0.15))
                              : null,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'Guardar ✓',
                          style: AppTypography.sans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: builder.cantos.isEmpty
                                ? (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary)
                                : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Step 1: Info General ───
class _Step1Info extends StatelessWidget {
  final TextEditingController tituloCtrl;
  final TextEditingController parroquiaCtrl;
  final HojitaBuilderState builder;
  final HojitaBuilderNotifier notifier;

  const _Step1Info({
    required this.tituloCtrl,
    required this.parroquiaCtrl,
    required this.builder,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
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
            decoration: InputDecoration(
              labelText: 'Nombre de la hojita',
              hintText: 'Ej: Misa Dominical - 3er Domingo',
              labelStyle: AppTypography.sans(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: builder.fecha,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (date != null) notifier.setFecha(date);
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Fecha de la celebración',
                labelStyle: AppTypography.sans(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
                suffixIcon: Icon(Icons.calendar_today_rounded,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                    size: 20),
              ),
              child: Text(
                '${builder.fecha.day}/${builder.fecha.month}/${builder.fecha.year}',
                style: AppTypography.sans(
                  fontSize: 16,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: parroquiaCtrl,
            style: AppTypography.sans(
              fontSize: 16,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              labelText: 'Parroquia (opcional)',
              hintText: 'Ej: Parroquia San José',
              labelStyle: AppTypography.sans(
                fontSize: 14,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 28),

          Text('TIPO DE MISA', style: AppTypography.sectionLabel),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: const [
              _TipoMisaOption(
                  key_: 'dominical',
                  icon: Icons.church_outlined,
                  label: 'Dominical'),
              _TipoMisaOption(
                  key_: 'matrimonio',
                  icon: Icons.favorite_outline_rounded,
                  label: 'Matrimonio'),
              _TipoMisaOption(
                  key_: 'bautismo',
                  icon: Icons.water_drop_outlined,
                  label: 'Bautismo'),
              _TipoMisaOption(
                  key_: 'funeral',
                  icon: Icons.local_florist_outlined,
                  label: 'Funeral'),
              _TipoMisaOption(
                  key_: 'primeraComunion',
                  icon: Icons.local_dining_outlined,
                  label: 'Primera\nComunión'),
              _TipoMisaOption(
                  key_: 'otro',
                  icon: Icons.event_note_outlined,
                  label: 'Otro'),
            ],
          ),
          const SizedBox(height: 28),

          Text('PLANTILLA PDF', style: AppTypography.sectionLabel),
          const SizedBox(height: 12),
          PdfTemplateSelector(
            selected: builder.template,
            onChanged: notifier.setTemplate,
          ),
        ],
      ),
    );
  }
}

class _TipoMisaOption extends ConsumerWidget {
  final String key_;
  final IconData icon;
  final String label;

  const _TipoMisaOption({
    required this.key_,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.watch(hojitaBuilderProvider);
    final isActive = builder.tipoMisa == key_;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;

    return GestureDetector(
      onTap: () =>
          ref.read(hojitaBuilderProvider.notifier).setTipoMisa(key_),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.12)
              : (isDark
                  ? AppColors.darkBgSecondary
                  : AppColors.surfaceElevated),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive
                ? activeColor
                : (isDark
                    ? AppColors.darkTextSecondary
                        .withValues(alpha: 0.15)
                    : AppColors.textSecondary
                        .withValues(alpha: 0.12)),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive
                  ? activeColor
                  : (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 11,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? (isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary)
                    : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Step 2: Selección de Cantos ───
class _Step2Cantos extends StatelessWidget {
  final HojitaBuilderState builder;
  final HojitaBuilderNotifier notifier;

  const _Step2Cantos({required this.builder, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Expanded(
          child: builder.cantos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.goldLuminous
                                  .withValues(alpha: 0.1)
                              : AppColors.goldDeep
                                  .withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.music_note_rounded,
                          size: 30,
                          color: isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Agrega cantos a tu hojita',
                        style: AppTypography.serif(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toca el botón para buscar y seleccionar',
                        style: AppTypography.sans(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: builder.cantos.length,
                  itemBuilder: (context, index) {
                    final item = builder.cantos[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkBgSecondary
                            : AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isDark
                            ? null
                            : AppColors.warmElevation(
                                blur: 6,
                                offset: 2,
                                opacity: 0.04),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.goldLuminous
                                      .withValues(alpha: 0.12)
                                  : AppColors.goldDeep
                                      .withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 1}',
                              style: AppTypography.sans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.goldLuminous
                                    : AppColors.goldDeep,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.cantoTitulo,
                                  style: AppTypography.sans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  item.cantoAutor,
                                  style: AppTypography.sans(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors
                                            .darkTextSecondary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close_rounded,
                                color: AppColors.error, size: 20),
                            onPressed: () =>
                                notifier.removeCanto(item.cantoUuid),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const CantoSelectorSheet(),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? AppColors.goldLuminous
                        : AppColors.goldDeep,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: isDark
                          ? AppColors.goldLuminous
                          : AppColors.goldDeep,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Agregar Cantos',
                      style: AppTypography.sans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.goldLuminous
                            : AppColors.goldDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Step 3: Reordenar ───
class _Step3Reorder extends StatelessWidget {
  final HojitaBuilderState builder;
  final HojitaBuilderNotifier notifier;

  const _Step3Reorder({required this.builder, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (builder.cantos.isEmpty) {
      return Center(
        child: Text(
          'No hay cantos seleccionados.\nVuelve al paso anterior.',
          style: AppTypography.sans(
            fontSize: 16,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            'Arrastra para reordenar según el orden de la celebración',
            style: AppTypography.sans(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: builder.cantos.length,
            onReorder: notifier.reorderCantos,
            itemBuilder: (context, index) {
              final item = builder.cantos[index];
              return Container(
                key: ValueKey(item.cantoUuid),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBgSecondary
                      : AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isDark
                      ? null
                      : AppColors.warmElevation(
                          blur: 6, offset: 2, opacity: 0.04),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.goldLuminous
                                .withValues(alpha: 0.12)
                            : AppColors.goldDeep
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: AppTypography.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.goldLuminous
                              : AppColors.goldDeep,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.cantoTitulo,
                            style: AppTypography.sans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            item.cantoAutor,
                            style: AppTypography.sans(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded,
                          color: AppColors.error, size: 20),
                      onPressed: () =>
                          notifier.removeCanto(item.cantoUuid),
                    ),
                    Icon(
                      Icons.drag_handle_rounded,
                      color: isDark
                          ? AppColors.darkTextSecondary
                              .withValues(alpha: 0.4)
                          : AppColors.textSecondary
                              .withValues(alpha: 0.3),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

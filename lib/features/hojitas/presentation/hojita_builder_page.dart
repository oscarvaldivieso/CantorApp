import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojita_builder_provider.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/canto_selector_sheet.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/pdf_template_selector.dart';
import 'package:google_fonts/google_fonts.dart';

class HojitaBuilderPage extends HookConsumerWidget {
  const HojitaBuilderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.watch(hojitaBuilderProvider);
    final notifier = ref.read(hojitaBuilderProvider.notifier);
    final tituloCtrl = useTextEditingController(text: builder.titulo);
    final parroquiaCtrl =
        useTextEditingController(text: builder.parroquiaNombre);

    final steps = ['Info', 'Cantos', 'Ordenar'];

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navyDeep,
        title: Text(
          'Nueva Hojita',
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
          onPressed: () {
            notifier.reset();
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          // Stepper horizontal
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (i) {
                final isActive = builder.currentStep == i;
                final isDone = builder.currentStep > i;
                return Row(
                  children: [
                    if (i > 0)
                      Container(
                        width: 32,
                        height: 2,
                        color: isDone ? AppColors.gold : AppColors.parchment,
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
                                  ? AppColors.navyDeep
                                  : isDone
                                      ? AppColors.gold
                                      : AppColors.parchment,
                            ),
                            alignment: Alignment.center,
                            child: isDone
                                ? const Icon(Icons.check,
                                    color: AppColors.white, size: 16)
                                : Text(
                                    '${i + 1}',
                                    style: GoogleFonts.crimsonPro(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isActive
                                          ? AppColors.white
                                          : AppColors.textMuted,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[i],
                            style: GoogleFonts.crimsonPro(
                              fontSize: 11,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isActive
                                  ? AppColors.navyDeep
                                  : AppColors.textMuted,
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

          // Content
          Expanded(
            child: IndexedStack(
              index: builder.currentStep,
              children: [
                // Step 1: Info
                _Step1Info(
                  tituloCtrl: tituloCtrl,
                  parroquiaCtrl: parroquiaCtrl,
                  builder: builder,
                  notifier: notifier,
                ),
                // Step 2: Select Cantos
                _Step2Cantos(builder: builder, notifier: notifier),
                // Step 3: Reorder
                _Step3Reorder(builder: builder, notifier: notifier),
              ],
            ),
          ),

          // Bottom navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.parchment)),
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
                        style: GoogleFonts.crimsonPro(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (builder.currentStep < 2)
                    ElevatedButton(
                      onPressed: () {
                        notifier.setTitulo(tituloCtrl.text);
                        notifier.setParroquiaNombre(parroquiaCtrl.text);
                        notifier.setStep(builder.currentStep + 1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navyDeep,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Siguiente →',
                        style: GoogleFonts.crimsonPro(
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (builder.currentStep == 2)
                    ElevatedButton(
                      onPressed: builder.cantos.isEmpty
                          ? null
                          : () async {
                              notifier.setTitulo(tituloCtrl.text);
                              notifier.setParroquiaNombre(parroquiaCtrl.text);
                              final id = await notifier.save();
                              if (context.mounted) {
                                notifier.reset();
                                context.go('/hojitas/$id/preview');
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navyDeep,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Guardar ✓',
                        style: GoogleFonts.crimsonPro(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: tituloCtrl,
            style: GoogleFonts.crimsonPro(fontSize: 16),
            decoration: const InputDecoration(
              labelText: 'Nombre de la hojita',
              hintText: 'Ej: Misa Dominical - 3er Domingo',
            ),
          ),
          const SizedBox(height: 16),
          // Date picker
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
              decoration: const InputDecoration(
                labelText: 'Fecha de la celebración',
                suffixIcon:
                    Icon(Icons.calendar_today, color: AppColors.textMuted),
              ),
              child: Text(
                '${builder.fecha.day}/${builder.fecha.month}/${builder.fecha.year}',
                style: GoogleFonts.crimsonPro(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: parroquiaCtrl,
            style: GoogleFonts.crimsonPro(fontSize: 16),
            decoration: const InputDecoration(
              labelText: 'Parroquia (opcional)',
              hintText: 'Ej: Parroquia San José',
            ),
          ),
          const SizedBox(height: 24),

          // Tipo de misa
          Text(
            'TIPO DE MISA',
            style: GoogleFonts.crimsonPro(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: const [
              _TipoMisaOption(key_: 'dominical', emoji: '⛪', label: 'Dominical'),
              _TipoMisaOption(key_: 'matrimonio', emoji: '💍', label: 'Matrimonio'),
              _TipoMisaOption(key_: 'bautismo', emoji: '💧', label: 'Bautismo'),
              _TipoMisaOption(key_: 'funeral', emoji: '🕯️', label: 'Funeral'),
              _TipoMisaOption(
                  key_: 'primeraComunion',
                  emoji: '🍞',
                  label: 'Primera\nComunión'),
              _TipoMisaOption(key_: 'otro', emoji: '📋', label: 'Otro'),
            ],
          ),
          const SizedBox(height: 24),

          // Template selector
          Text(
            'PLANTILLA PDF',
            style: GoogleFonts.crimsonPro(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: AppColors.textMuted,
            ),
          ),
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
  final String emoji;
  final String label;

  const _TipoMisaOption({
    required this.key_,
    required this.emoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.watch(hojitaBuilderProvider);
    final isActive = builder.tipoMisa == key_;

    return GestureDetector(
      onTap: () => ref.read(hojitaBuilderProvider.notifier).setTipoMisa(key_),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.navyDeep.withValues(alpha: 0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.navyDeep : AppColors.parchment,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.crimsonPro(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppColors.navyDeep : AppColors.textMuted,
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
    return Column(
      children: [
        Expanded(
          child: builder.cantos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🎵', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text(
                        'Agrega cantos a tu hojita',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.navyDeep,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toca el botón para buscar y seleccionar',
                        style: GoogleFonts.crimsonPro(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColors.textMuted,
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
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.navyDeep,
                          radius: 16,
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.crimsonPro(
                              color: AppColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(
                          item.cantoTitulo,
                          style: GoogleFonts.crimsonPro(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          item.cantoAutor,
                          style: GoogleFonts.crimsonPro(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close,
                              color: AppColors.liturgyRed, size: 20),
                          onPressed: () => notifier.removeCanto(item.cantoUuid),
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const CantoSelectorSheet(),
                );
              },
              icon: const Icon(Icons.add, color: AppColors.navyDeep),
              label: Text(
                'Agregar Cantos',
                style: GoogleFonts.crimsonPro(
                  fontWeight: FontWeight.w600,
                  color: AppColors.navyDeep,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.navyDeep),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
    if (builder.cantos.isEmpty) {
      return Center(
        child: Text(
          'No hay cantos seleccionados.\nVuelve al paso anterior.',
          style: GoogleFonts.crimsonPro(
            fontSize: 16,
            color: AppColors.textMuted,
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Arrastra para reordenar los cantos según el orden de la celebración',
            style: GoogleFonts.crimsonPro(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.textMuted,
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
              return Card(
                key: ValueKey(item.cantoUuid),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.navyDeep,
                    radius: 16,
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.crimsonPro(
                        color: AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  title: Text(
                    item.cantoTitulo,
                    style: GoogleFonts.crimsonPro(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item.cantoAutor,
                    style: GoogleFonts.crimsonPro(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: AppColors.liturgyRed, size: 20),
                        onPressed: () =>
                            notifier.removeCanto(item.cantoUuid),
                      ),
                      const Icon(Icons.drag_handle,
                          color: AppColors.parchment),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

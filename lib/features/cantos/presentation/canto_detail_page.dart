import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/presentation/providers/canto_detail_provider.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/acordes_widget.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/tonality_selector.dart';
import 'package:cantor_app/shared/widgets/liturgical_chip.dart';
import 'package:google_fonts/google_fonts.dart';

class CantoDetailPage extends ConsumerWidget {
  final int cantoId;
  const CantoDetailPage({super.key, required this.cantoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantoAsync = ref.watch(cantoDetailProvider(cantoId));
    final selectedTonality = ref.watch(selectedTonalityProvider(cantoId));

    return cantoAsync.when(
      data: (canto) {
        if (canto == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('No encontrado')),
            body: const Center(child: Text('Canto no encontrado')),
          );
        }

        final tonality = selectedTonality ?? canto.tonalidad;
        final showChords = canto.acordes != null && canto.acordes!.isNotEmpty;

        return Scaffold(
          backgroundColor: AppColors.cream,
          body: CustomScrollView(
            slivers: [
              // Header
              SliverAppBar(
                expandedHeight: 160,
                pinned: true,
                backgroundColor: AppColors.navyDeep,
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
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.navyGradient,
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          canto.titulo,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (canto.autor != null)
                          Text(
                            canto.autor!,
                            style: GoogleFonts.crimsonPro(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: AppColors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: canto.tiempos
                              .map((t) =>
                                  LiturgicalChip(tiempo: t, small: true))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Tonality Selector (if has chords)
              if (showChords) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'TONALIDAD',
                            style: GoogleFonts.crimsonPro(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TonalitySelector(
                          currentTonality: tonality,
                          onChanged: (nota) => ref
                              .read(
                                  selectedTonalityProvider(cantoId).notifier)
                              .state = nota,
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Letra / Acordes content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: showChords
                      ? AcordesWidget(
                          chordProText: canto.acordes!,
                          originalTonality: canto.tonalidad,
                          targetTonality: tonality,
                        )
                      : _buildLetra(canto.letra),
                ),
              ),

              // Full lyrics below chords
              if (showChords)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: AppColors.parchment),
                        const SizedBox(height: 8),
                        Text(
                          'LETRA COMPLETA',
                          style: GoogleFonts.crimsonPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildLetra(canto.letra),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.navyDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Agregar a Hojita',
                      style: GoogleFonts.crimsonPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.gold, AppColors.goldLight],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '+ Agregar',
                      style: GoogleFonts.crimsonPro(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navyDeep,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildLetra(String letra) {
    final lines = letra.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.trim() == '{C}') {
          return Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
              'CORO:',
              style: GoogleFonts.crimsonPro(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
                letterSpacing: 1.2,
              ),
            ),
          );
        }
        if (line.trim().startsWith('{E')) {
          final match = RegExp(r'\{E(\d+)\}').firstMatch(line.trim());
          final num = match?.group(1) ?? '';
          return Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
              'ESTROFA $num:',
              style: GoogleFonts.crimsonPro(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.navyDeep,
                letterSpacing: 1.2,
              ),
            ),
          );
        }
        if (line.trim().isEmpty) return const SizedBox(height: 8);
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            line,
            style: GoogleFonts.crimsonPro(
              fontSize: 17,
              height: 1.8,
              color: AppColors.textDark,
            ),
          ),
        );
      }).toList(),
    );
  }
}

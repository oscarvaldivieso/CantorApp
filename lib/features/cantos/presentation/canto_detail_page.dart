import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/presentation/providers/canto_detail_provider.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/acordes_widget.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/tonality_selector.dart';
import 'package:cantor_app/shared/widgets/liturgical_chip.dart';

class CantoDetailPage extends ConsumerWidget {
  final int cantoId;
  const CantoDetailPage({super.key, required this.cantoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantoAsync = ref.watch(cantoDetailProvider(cantoId));
    final selectedTonality = ref.watch(selectedTonalityProvider(cantoId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return cantoAsync.when(
      data: (canto) {
        if (canto == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('No encontrado')),
            body: const Center(child: Text('Canto no encontrado')),
          );
        }

        final tonality = selectedTonality ?? canto.tonalidad;
        final showChords =
            canto.acordes != null && canto.acordes!.isNotEmpty;

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
          body: CustomScrollView(
            slivers: [
              // ─── Collapsible Header ───
              SliverAppBar(
                expandedHeight: showChords ? 236 : 180,
                pinned: true,
                backgroundColor:
                    isDark ? AppColors.darkBg : AppColors.cream,
                surfaceTintColor: Colors.transparent,
                leading: _BackButton(isDark: isDark),
                leadingWidth: 56,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                ],
                bottom: showChords
                    ? _TransposeBar(
                        tonality: tonality,
                        isDark: isDark,
                        onChanged: (nota) => ref
                            .read(selectedTonalityProvider(cantoId)
                                .notifier)
                            .state = nota,
                      )
                    : null,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                AppColors.darkBgSecondary,
                                AppColors.darkBg,
                              ]
                            : [
                                AppColors.cream,
                                AppColors.warmWhite,
                              ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding:
                        const EdgeInsets.fromLTRB(24, 90, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Title
                        Hero(
                          tag: 'canto_title_${canto.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              canto.titulo,
                              style: AppTypography.serif(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Author
                        if (canto.autor != null)
                          Text(
                            canto.autor!,
                            style: AppTypography.sans(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        const SizedBox(height: 10),
                        // Liturgical chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: canto.tiempos
                              .map((t) => LiturgicalChip(
                                  tiempo: t, small: true))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  title: null,
                ),
              ),

              // ─── Chord + Lyrics Content ───
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: showChords
                      ? AcordesWidget(
                          chordProText: canto.acordes!,
                          originalTonality: canto.tonalidad,
                          targetTonality: tonality,
                        )
                      : _buildLetra(canto.letra, isDark),
                ),
              ),

              // ─── Full lyrics section below chords ───
              if (showChords)
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: isDark
                              ? AppColors.darkTextSecondary
                                  .withValues(alpha: 0.15)
                              : AppColors.textSecondary
                                  .withValues(alpha: 0.1),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'LETRA COMPLETA',
                          style: AppTypography.sectionLabel,
                        ),
                        const SizedBox(height: 16),
                        _buildLetra(canto.letra, isDark),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // ─── Bottom Action Bar ───
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBgSecondary
                  : AppColors.surfaceElevated,
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: AppColors.warmShadow
                            .withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Font size controls
                  _BottomAction(
                    icon: Icons.text_decrease_rounded,
                    isDark: isDark,
                    onTap: () {},
                  ),
                  _BottomAction(
                    icon: Icons.text_increase_rounded,
                    isDark: isDark,
                    onTap: () {},
                  ),
                  const SizedBox(width: 4),
                  // Toggle chords
                  if (showChords)
                    _BottomAction(
                      icon: Icons.music_note_rounded,
                      isDark: isDark,
                      onTap: () {},
                    ),
                  const Spacer(),
                  // Add to Hojita
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add_rounded,
                            color: AppColors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Agregar a Hojita',
                            style: AppTypography.sans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
        body: Center(
          child: CircularProgressIndicator(
            color:
                isDark ? AppColors.goldLuminous : AppColors.goldDeep,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildLetra(String letra, bool isDark) {
    final lines = letra.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        // Chorus marker
        if (line.trim() == '{C}') {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: isDark
                        ? AppColors.goldLuminous.withValues(alpha: 0.3)
                        : AppColors.goldDeep.withValues(alpha: 0.3),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'ESTRIBILLO',
                    style: AppTypography.sans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: isDark
                          ? AppColors.goldLuminous
                          : AppColors.goldDeep,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: isDark
                        ? AppColors.goldLuminous
                            .withValues(alpha: 0.3)
                        : AppColors.goldDeep.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          );
        }
        // Verse marker
        if (line.trim().startsWith('{E')) {
          final match =
              RegExp(r'\{E(\d+)\}').firstMatch(line.trim());
          final num = match?.group(1) ?? '';
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: isDark
                        ? AppColors.darkTextSecondary
                            .withValues(alpha: 0.2)
                        : AppColors.textSecondary
                            .withValues(alpha: 0.15),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'VERSO $num',
                    style: AppTypography.sans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: isDark
                        ? AppColors.darkTextSecondary
                            .withValues(alpha: 0.2)
                        : AppColors.textSecondary
                            .withValues(alpha: 0.15),
                  ),
                ),
              ],
            ),
          );
        }
        // Empty line
        if (line.trim().isEmpty) {
          return const SizedBox(height: 10);
        }
        // Normal lyric line
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            line,
            style: AppTypography.sans(
              fontSize: 18,
              height: 1.7,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Back Button ───
class _BackButton extends StatelessWidget {
  final bool isDark;
  const _BackButton({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton(
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBgSecondary
                : AppColors.surfaceElevated,
            shape: BoxShape.circle,
            boxShadow: isDark
                ? null
                : AppColors.warmElevation(
                    blur: 6, offset: 1, opacity: 0.06),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 18,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

// ─── Bottom Action Button ───
class _BottomAction extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _BottomAction({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Icon(
          icon,
          size: 22,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ─── Transpose Bar (used as SliverAppBar.bottom) ───
class _TransposeBar extends StatelessWidget implements PreferredSizeWidget {
  final String? tonality;
  final bool isDark;
  final ValueChanged<String> onChanged;

  const _TransposeBar({
    required this.tonality,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: isDark ? AppColors.darkBg : AppColors.cream,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Transpose down
          _TransposeButton(
            icon: Icons.remove_rounded,
            isDark: isDark,
            onTap: () {
              HapticFeedback.selectionClick();
            },
          ),
          const SizedBox(width: 16),
          // Current tonality
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) {
              return FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              );
            },
            child: Text(
              tonality ?? '—',
              key: ValueKey(tonality),
              style: AppTypography.mono(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? AppColors.goldLuminous
                    : AppColors.goldDeep,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Transpose up
          _TransposeButton(
            icon: Icons.add_rounded,
            isDark: isDark,
            onTap: () {
              HapticFeedback.selectionClick();
            },
          ),
          const Spacer(),
          // Full tonality selector
          Expanded(
            child: SizedBox(
              height: 36,
              child: TonalitySelector(
                currentTonality: tonality,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransposeButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _TransposeButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgSecondary
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isDark
              ? null
              : AppColors.warmElevation(
                  blur: 6, offset: 1, opacity: 0.05),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.textPrimary,
        ),
      ),
    );
  }
}

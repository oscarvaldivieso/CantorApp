import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:cantor_app/core/utils/liturgical_calendar.dart';
import 'package:cantor_app/core/theme/liturgical_theme.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojitas_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantosAsync = ref.watch(cantosStreamProvider);
    final hojitasAsync = ref.watch(hojitasStreamProvider);
    final tiempoActual = LiturgicalCalendar.tiempoActual();
    final tiempoColor = LiturgicalTheme.colorForTiempo(tiempoActual);
    final tiempoLabel = LiturgicalTheme.labelForTiempo(tiempoActual);
    final tiempoEmoji = LiturgicalTheme.emojiForTiempo(tiempoActual);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.navyDeep,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.navyGradient),
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '✝ CantorApp',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tu cantoral digital católico',
                      style: GoogleFonts.crimsonPro(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: AppColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Liturgical time chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: tiempoColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: tiempoColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tiempoEmoji,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            tiempoLabel,
                            style: GoogleFonts.crimsonPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      emoji: '🎵',
                      label: 'Cantos',
                      value: cantosAsync.when(
                        data: (c) => '${c.length}',
                        loading: () => '...',
                        error: (_, __) => '0',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      emoji: '📋',
                      label: 'Hojitas',
                      value: hojitasAsync.when(
                        data: (h) => '${h.length}',
                        loading: () => '...',
                        error: (_, __) => '0',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACCIONES RÁPIDAS',
                    style: GoogleFonts.crimsonPro(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _QuickAction(
                    emoji: '🎵',
                    title: 'Explorar Cantos',
                    subtitle: 'Busca y descubre cantos litúrgicos',
                    onTap: () => context.go(kCantos),
                  ),
                  const SizedBox(height: 10),
                  _QuickAction(
                    emoji: '📋',
                    title: 'Crear Hojita',
                    subtitle: 'Arma la hoja de cantos para tu celebración',
                    onTap: () => context.push(kHojitaNueva),
                  ),
                  const SizedBox(height: 10),
                  _QuickAction(
                    emoji: '➕',
                    title: 'Agregar Canto',
                    subtitle: 'Añade un nuevo canto al cantoral',
                    onTap: () => context.push(kCantoEditor),
                  ),
                  const SizedBox(height: 10),
                  _QuickAction(
                    emoji: '📖',
                    title: 'Mis Hojitas',
                    subtitle: 'Revisa tu historial de hojas de cantos',
                    onTap: () => context.go(kHojitas),
                  ),
                ],
              ),
            ),
          ),

          // Recent hojitas
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Text(
                'HOJITAS RECIENTES',
                style: GoogleFonts.crimsonPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),

          hojitasAsync.when(
            data: (hojitas) {
              if (hojitas.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text('📋',
                                style: TextStyle(fontSize: 32)),
                            const SizedBox(height: 8),
                            Text(
                              'Aún no tienes hojitas',
                              style: GoogleFonts.crimsonPro(
                                fontSize: 14,
                                color: AppColors.textMuted,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              final recent = hojitas.take(3).toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final h = recent[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: Card(
                        child: ListTile(
                          onTap: () =>
                              context.push('/hojitas/${h.id}/preview'),
                          leading: const Text('📋',
                              style: TextStyle(fontSize: 24)),
                          title: Text(
                            h.titulo,
                            style: GoogleFonts.crimsonPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${h.cantos.length} cantos',
                            style: GoogleFonts.crimsonPro(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: AppColors.parchment),
                        ),
                      ),
                    );
                  },
                  childCount: recent.length,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.gold),
                ),
              ),
            ),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox()),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _StatCard({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyDeep,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.crimsonPro(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAction({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.gold.withValues(alpha: 0.2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.crimsonPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.crimsonPro(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.parchment),
            ],
          ),
        ),
      ),
    );
  }
}

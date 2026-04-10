import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:cantor_app/core/utils/liturgical_calendar.dart';
import 'package:cantor_app/core/theme/liturgical_theme.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/canto_card.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojitas_provider.dart';
import 'package:cantor_app/shared/widgets/liturgical_badge.dart';
import 'package:cantor_app/shared/widgets/sacred_search_bar.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantosAsync = ref.watch(cantosStreamProvider);
    final hojitasAsync = ref.watch(hojitasStreamProvider);
    final tiempoActual = LiturgicalCalendar.tiempoActual();
    final tiempoColor = LiturgicalTheme.colorForTiempo(tiempoActual);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    tiempoColor.withValues(alpha: isDark ? 0.12 : 0.08),
                    isDark ? AppColors.darkBg : AppColors.cream,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Paz y bien',
                              style: AppTypography.serif(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.goldLuminous
                                    : AppColors.goldDeep,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkBgSecondary
                                  : AppColors.surfaceElevated,
                              shape: BoxShape.circle,
                              boxShadow: isDark
                                  ? null
                                  : AppColors.warmElevation(
                                      blur: 8,
                                      offset: 2,
                                      opacity: 0.06,
                                    ),
                            ),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 20,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LiturgicalBadge(tiempo: tiempoActual),
                      const SizedBox(height: 20),
                      SacredSearchBar(
                        readOnly: true,
                        onTap: () => context.go(kCantos),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Hoja del Dia
          hojitasAsync.when(
            data: (hojitas) {
              final today = DateTime.now();
              final todayHojitas = hojitas.where((h) {
                return h.fecha.year == today.year &&
                    h.fecha.month == today.month &&
                    h.fecha.day == today.day;
              }).toList();

              if (todayHojitas.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }

              final hojita = todayHojitas.first;
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                  child: GestureDetector(
                    onTap: () =>
                        context.push('/hojitas/${hojita.id}/preview'),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            tiempoColor.withValues(alpha: 0.12),
                            tiempoColor.withValues(alpha: 0.04),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: tiempoColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.auto_stories_rounded,
                                color: tiempoColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'HOJA DEL DIA',
                                style: AppTypography.sans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: tiempoColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            hojita.titulo,
                            style: AppTypography.serif(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('EEEE d MMMM', 'es')
                                .format(hojita.fecha),
                            style: AppTypography.sans(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...hojita.cantos.take(4).map(
                                (c) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    '· ${c.cantoTitulo}',
                                    style: AppTypography.sans(
                                      fontSize: 13,
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            loading: () =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, __) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // Cantos Recientes
          cantosAsync.when(
            data: (cantos) {
              if (cantos.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              final recent = cantos.take(8).toList();
              return SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                      child: Text(
                        'CANTOS RECIENTES',
                        style: AppTypography.sectionLabel,
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24),
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 12),
                        itemCount: recent.length,
                        itemBuilder: (context, index) {
                          final canto = recent[index];
                          return CantoCardCompact(
                            canto: canto,
                            onTap: () =>
                                context.push('/cantos/${canto.id}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () =>
                const SliverToBoxAdapter(child: SizedBox(height: 130)),
            error: (_, __) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // Explorar por Momento
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Text(
                'EXPLORAR POR MOMENTO',
                style: AppTypography.sectionLabel,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = _momentCategories[index];
                  return _MomentCard(
                    label: cat['label'] as String,
                    icon: cat['icon'] as IconData,
                    tintColor: cat['color'] as Color,
                    count: cantosAsync.whenOrNull(
                      data: (cantos) => cantos
                          .where((c) =>
                              c.categorias.contains(cat['key'] as String))
                          .length,
                    ),
                    onTap: () {
                      ref
                          .read(selectedCategoriaProvider.notifier)
                          .state = cat['key'] as String;
                      context.go(kCantos);
                    },
                  );
                },
                childCount: _momentCategories.length,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
              ),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
              child: Text(
                'ACCIONES RAPIDAS',
                style: AppTypography.sectionLabel,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _QuickActionCard(
                    icon: Icons.add_rounded,
                    title: 'Crear Hojita',
                    subtitle: 'Arma la hoja de cantos para la misa',
                    onTap: () => context.push(kHojitaNueva),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 10),
                  _QuickActionCard(
                    icon: Icons.edit_note_rounded,
                    title: 'Agregar Canto',
                    subtitle: 'Anade un nuevo canto al cantoral',
                    onTap: () => context.push(kCantoEditor),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          // Hojitas Recientes
          hojitasAsync.when(
            data: (hojitas) {
              if (hojitas.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              final recent = hojitas.take(3).toList();
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HOJITAS RECIENTES',
                        style: AppTypography.sectionLabel,
                      ),
                      const SizedBox(height: 12),
                      ...recent.map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () =>
                                context.push('/hojitas/${h.id}/preview'),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkBgSecondary
                                    : AppColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: isDark
                                    ? null
                                    : AppColors.warmElevation(
                                        blur: 8,
                                        offset: 2,
                                        opacity: 0.05,
                                      ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.goldLuminous
                                              .withValues(alpha: 0.12)
                                          : AppColors.goldDeep
                                              .withValues(alpha: 0.08),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.auto_stories_rounded,
                                      size: 20,
                                      color: isDark
                                          ? AppColors.goldLuminous
                                          : AppColors.goldDeep,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          h.titulo,
                                          style: AppTypography.sans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? AppColors.darkTextPrimary
                                                : AppColors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          '${h.cantos.length} cantos · ${DateFormat('d MMM', 'es').format(h.fecha)}',
                                          style: AppTypography.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                            .withValues(alpha: 0.4)
                                        : AppColors.textSecondary
                                            .withValues(alpha: 0.3),
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, __) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Data ───

final _momentCategories = [
  {
    'key': 'entrada',
    'label': 'Entrada',
    'icon': Icons.door_front_door_outlined,
    'color': AppColors.liturgyGreen,
  },
  {
    'key': 'gloria',
    'label': 'Gloria',
    'icon': Icons.auto_awesome_outlined,
    'color': AppColors.goldDeep,
  },
  {
    'key': 'salmo',
    'label': 'Salmo',
    'icon': Icons.menu_book_rounded,
    'color': AppColors.liturgyBlue,
  },
  {
    'key': 'aleluya',
    'label': 'Aleluya',
    'icon': Icons.celebration_outlined,
    'color': AppColors.goldDeep,
  },
  {
    'key': 'ofertorio',
    'label': 'Ofertorio',
    'icon': Icons.volunteer_activism_outlined,
    'color': AppColors.liturgyGreen,
  },
  {
    'key': 'santo',
    'label': 'Santo',
    'icon': Icons.notifications_active_outlined,
    'color': AppColors.liturgyPurple,
  },
  {
    'key': 'comunion',
    'label': 'Comunión',
    'icon': Icons.local_drink_outlined,
    'color': AppColors.burgundy,
  },
  {
    'key': 'salida',
    'label': 'Salida',
    'icon': Icons.directions_walk_rounded,
    'color': AppColors.liturgyGreen,
  },
];

// ─── Sub-Widgets ───

class _MomentCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color tintColor;
  final int? count;
  final VoidCallback onTap;

  const _MomentCard({
    required this.label,
    required this.icon,
    required this.tintColor,
    this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgSecondary
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDark
              ? null
              : AppColors.warmElevation(
                  blur: 10, offset: 3, opacity: 0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: tintColor.withValues(alpha: isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: tintColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.sans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                if (count != null)
                  Text(
                    '$count cantos',
                    style: AppTypography.sans(
                      fontSize: 11,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
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

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgSecondary
              : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? null
              : AppColors.warmElevation(
                  blur: 10, offset: 3, opacity: 0.05),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.goldLuminous.withValues(alpha: 0.12)
                    : AppColors.goldDeep.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 22,
                color: isDark
                    ? AppColors.goldLuminous
                    : AppColors.goldDeep,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.sans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark
                  ? AppColors.darkTextSecondary.withValues(alpha: 0.4)
                  : AppColors.textSecondary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
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
import 'package:cantor_app/shared/widgets/glass_card.dart';
import 'package:cantor_app/shared/widgets/vitral_header.dart';
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
    final palette = LiturgicalVisualPalette.forTiempo(tiempoActual, isDark);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Hero Header Section ───
          SliverToBoxAdapter(
            child: VitralHeader(
              tiempo: tiempoActual,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Season label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: tiempoColor.withValues(alpha: isDark ? 0.20 : 0.10),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: tiempoColor.withValues(alpha: isDark ? 0.35 : 0.20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: tiempoColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              palette.title.toUpperCase(),
                              style: AppTypography.sans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8,
                                color: isDark
                                    ? tiempoColor.withValues(alpha: 0.9)
                                    : tiempoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Main greeting title
                      Text(
                        'Paz y bien',
                        style: AppTypography.serif(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Devotional phrase
                      Text(
                        palette.devotionalPhrase,
                        style: AppTypography.serif(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                          height: 1.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Date line
                      Text(
                        DateFormat('EEEE, d \'de\' MMMM', 'es').format(DateTime.now()),
                        style: AppTypography.sans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkTextSecondary.withValues(alpha: 0.7)
                              : AppColors.textSecondary.withValues(alpha: 0.8),
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Search bar
                      GestureDetector(
                        onTap: () => context.go(kCantos),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkBgSecondary.withValues(alpha: 0.7)
                                : AppColors.surfaceElevated.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withValues(alpha: 0.2)
                                    : AppColors.warmShadow.withValues(alpha: 0.10),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 20,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Buscar cantos, salmos, himnos...',
                                style: AppTypography.sans(
                                  fontSize: 15,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.textSecondary,
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
            ),
          ),

          // ─── Hoja del Día (if exists) ───
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
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: GlassCard(
                    tintColor: tiempoColor,
                    padding: const EdgeInsets.all(20),
                    onTap: () => context.push('/hojitas/${hojita.id}/preview'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: tiempoColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.auto_stories_rounded,
                                color: tiempoColor,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'HOJA DEL DÍA',
                              style: AppTypography.sans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: tiempoColor,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 20,
                              color: isDark
                                  ? AppColors.darkTextSecondary.withValues(alpha: 0.4)
                                  : AppColors.textSecondary.withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
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
                          '${hojita.cantos.length} cantos · ${DateFormat('d MMM', 'es').format(hojita.fecha)}',
                          style: AppTypography.sans(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // ─── Cantos Recientes ───
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
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cantos recientes',
                            style: AppTypography.sans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(kCantos),
                            child: Text(
                              'Ver todos',
                              style: AppTypography.sans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.goldLuminous
                                    : AppColors.goldDeep,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 140,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: recent.length,
                        itemBuilder: (context, index) {
                          final canto = recent[index];
                          return CantoCardCompact(
                            canto: canto,
                            onTap: () => context.push('/cantos/${canto.id}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: SizedBox(height: 140),
            ),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // ─── Cantos por Tiempo Litúrgico ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 14),
              child: Text(
                'Cantos por tiempo litúrgico',
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: _liturgicalSeasons.length,
                itemBuilder: (context, index) {
                  final season = _liturgicalSeasons[index];
                  final isActive = season['key'] == tiempoActual;
                  final color = season['color'] as Color;
                  final asset = season['asset'] as String;

                  return GestureDetector(
                    onTap: () {
                      context.go(kCantos);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkBgSecondary.withValues(alpha: 0.85)
                            : AppColors.surfaceElevated.withValues(alpha: 0.90),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive
                              ? color.withValues(alpha: isDark ? 0.5 : 0.35)
                              : isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : Colors.white.withValues(alpha: 0.5),
                          width: isActive ? 1.5 : 1,
                        ),
                        boxShadow: [
                          if (isActive)
                            BoxShadow(
                              color: color.withValues(alpha: isDark ? 0.15 : 0.10),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            )
                          else
                            BoxShadow(
                              color: isDark
                                  ? Colors.black.withValues(alpha: 0.15)
                                  : AppColors.warmShadow.withValues(alpha: 0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Pattern image background
                          Positioned(
                            right: -10,
                            top: -10,
                            width: 90,
                            height: 90,
                            child: Opacity(
                              opacity: isActive
                                  ? (isDark ? 0.15 : 0.18)
                                  : (isDark ? 0.06 : 0.08),
                              child: Image.asset(
                                asset,
                                fit: BoxFit.cover,
                                color: color.withValues(alpha: 0.6),
                                colorBlendMode: BlendMode.overlay,
                              ),
                            ),
                          ),
                          // Gradient overlay to ensure text readability
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    (isDark
                                            ? AppColors.darkBgSecondary
                                            : AppColors.surfaceElevated)
                                        .withValues(alpha: 0.6),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  season['emoji'] as String,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      season['label'] as String,
                                      style: AppTypography.sans(
                                        fontSize: 13,
                                        fontWeight: isActive
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: isActive
                                            ? color
                                            : isDark
                                                ? AppColors.darkTextPrimary
                                                : AppColors.textPrimary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (isActive)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.withValues(
                                              alpha: isDark ? 0.20 : 0.12),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Actual',
                                          style: AppTypography.sans(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.8,
                                            color: color,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ─── Explorar por Momento ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explorar por momento',
                    style: AppTypography.sans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cantos según el orden de la Santa Misa',
                    style: AppTypography.sans(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = _momentCategories[index];
                  return _MomentCard(
                    label: cat['label'] as String,
                    subtitle: cat['subtitle'] as String,
                    icon: cat['icon'] as IconData,
                    tintColor: cat['color'] as Color,
                    order: cat['order'] as String,
                    count: cantosAsync.whenOrNull(
                      data: (cantos) => cantos
                          .where((c) =>
                              c.categorias.contains(cat['key'] as String))
                          .length,
                    ),
                    onTap: () {
                      ref.read(selectedCategoriaProvider.notifier).state =
                          cat['key'] as String;
                      context.go(kCantos);
                    },
                  );
                },
                childCount: _momentCategories.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
            ),
          ),

          // ─── Acciones Rápidas ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 14),
              child: Text(
                'Acciones rápidas',
                style: AppTypography.sans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
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
                    accentColor: isDark ? AppColors.goldLuminous : AppColors.goldDeep,
                  ),
                  const SizedBox(height: 10),
                  _QuickActionCard(
                    icon: Icons.edit_note_rounded,
                    title: 'Agregar Canto',
                    subtitle: 'Añade un nuevo canto al cantoral',
                    onTap: () => context.push(kCantoEditor),
                    isDark: isDark,
                    accentColor: isDark ? AppColors.goldLuminous : AppColors.goldDeep,
                  ),
                ],
              ),
            ),
          ),

          // ─── Hojitas Recientes ───
          hojitasAsync.when(
            data: (hojitas) {
              if (hojitas.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              final recent = hojitas.take(3).toList();
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hojitas recientes',
                            style: AppTypography.sans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(kHojitas),
                            child: Text(
                              'Ver todas',
                              style: AppTypography.sans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.goldLuminous
                                    : AppColors.goldDeep,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ...recent.map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GlassCard(
                            padding: const EdgeInsets.all(16),
                            onTap: () =>
                                context.push('/hojitas/${h.id}/preview'),
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
                                    borderRadius: BorderRadius.circular(13),
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
                                      const SizedBox(height: 2),
                                      Text(
                                        '${h.cantos.length} cantos · ${DateFormat('d MMM', 'es').format(h.fecha)}',
                                        style: AppTypography.sans(
                                          fontSize: 12,
                                          color: isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                          .withValues(alpha: 0.3)
                                      : AppColors.textSecondary
                                          .withValues(alpha: 0.3),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          // Bottom safe padding
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─── Data ───

final _liturgicalSeasons = [
  {'key': 'adviento', 'label': 'Adviento', 'emoji': '🕯️', 'color': AppColors.liturgyPurple, 'asset': 'lib/assets/adviento.png'},
  {'key': 'navidad', 'label': 'Navidad', 'emoji': '⭐', 'color': AppColors.liturgyGoldBright, 'asset': 'lib/assets/navidad.png'},
  {'key': 'cuaresma', 'label': 'Cuaresma', 'emoji': '✝️', 'color': AppColors.liturgyPurple, 'asset': 'lib/assets/cuaresma.png'},
  {'key': 'pascua', 'label': 'Pascua', 'emoji': '🐑', 'color': AppColors.liturgyGoldBright, 'asset': 'lib/assets/pascua.png'},
  {'key': 'pentecostes', 'label': 'Pentecostés', 'emoji': '🔥', 'color': AppColors.liturgyRed, 'asset': 'lib/assets/pascua.png'},
  {'key': 'ordinario', 'label': 'Ordinario', 'emoji': '🌿', 'color': AppColors.liturgyGreen, 'asset': 'lib/assets/ordinario.png'},
];

// Mass moments ordered liturgically — Liturgia de la Palabra → Liturgia Eucarística → Envío
final _momentCategories = [
  {
    'key': 'entrada',
    'label': 'Entrada',
    'subtitle': 'Procesión inicial',
    'icon': Icons.meeting_room_outlined,
    'color': AppColors.liturgyGreen,
    'order': '1',
  },
  {
    'key': 'gloria',
    'label': 'Gloria',
    'subtitle': 'Himno de alabanza',
    'icon': Icons.auto_awesome_rounded,
    'color': AppColors.goldDeep,
    'order': '2',
  },
  {
    'key': 'salmo',
    'label': 'Salmo',
    'subtitle': 'Salmo responsorial',
    'icon': Icons.menu_book_rounded,
    'color': AppColors.liturgyBlue,
    'order': '3',
  },
  {
    'key': 'aleluya',
    'label': 'Aleluya',
    'subtitle': 'Aclamación al Evangelio',
    'icon': Icons.music_note_rounded,
    'color': AppColors.liturgyGoldBright,
    'order': '4',
  },
  {
    'key': 'ofertorio',
    'label': 'Ofertorio',
    'subtitle': 'Presentación de dones',
    'icon': Icons.volunteer_activism_rounded,
    'color': AppColors.liturgyGreen,
    'order': '5',
  },
  {
    'key': 'santo',
    'label': 'Santo',
    'subtitle': 'Sanctus',
    'icon': Icons.church_rounded,
    'color': AppColors.liturgyPurple,
    'order': '6',
  },
  {
    'key': 'comunion',
    'label': 'Comunión',
    'subtitle': 'Fracción del pan',
    'icon': Icons.wine_bar_rounded,
    'color': AppColors.burgundy,
    'order': '7',
  },
  {
    'key': 'salida',
    'label': 'Salida',
    'subtitle': 'Envío y misión',
    'icon': Icons.wb_sunny_outlined,
    'color': AppColors.liturgyGreen,
    'order': '8',
  },
];

// ─── Sub-Widgets ───

class _MomentCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color tintColor;
  final String order;
  final int? count;
  final VoidCallback onTap;

  const _MomentCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.tintColor,
    required this.order,
    this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgSecondary.withValues(alpha: 0.85)
              : AppColors.surfaceElevated.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : tintColor.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.12)
                  : tintColor.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle with subtle gradient
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    tintColor.withValues(alpha: isDark ? 0.22 : 0.12),
                    tintColor.withValues(alpha: isDark ? 0.10 : 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: tintColor.withValues(alpha: isDark ? 0.20 : 0.12),
                  width: 0.5,
                ),
              ),
              child: Icon(
                icon,
                size: 22,
                color: tintColor,
              ),
            ),
            const SizedBox(height: 8),
            // Label
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            // Count
            if (count != null)
              Text(
                '$count',
                style: AppTypography.sans(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                ),
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
  final Color accentColor;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              size: 22,
              color: accentColor,
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.sans(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDark
                ? AppColors.darkTextSecondary.withValues(alpha: 0.3)
                : AppColors.textSecondary.withValues(alpha: 0.3),
            size: 20,
          ),
        ],
      ),
    );
  }
}
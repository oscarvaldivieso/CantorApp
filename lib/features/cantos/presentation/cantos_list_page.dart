import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/canto_card.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';
import 'package:cantor_app/shared/widgets/sacred_search_bar.dart';

class CantosListPage extends HookConsumerWidget {
  const CantosListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final cantosAsync = ref.watch(cantosFilteredProvider);
    final selectedCat = ref.watch(selectedCategoriaProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // ─── Top Safe Area + Title ───
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Text(
                  'Cantos',
                  style: AppTypography.serif(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),

          // ─── Search Bar ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: SacredSearchBar(
                controller: searchController,
                onChanged: (v) =>
                    ref.read(searchQueryProvider.notifier).state = v,
              ),
            ),
          ),

          // ─── Category Filter Chips ───
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _FilterChip(
                    label: 'Todos',
                    isActive: selectedCat == null,
                    onTap: () => ref
                        .read(selectedCategoriaProvider.notifier)
                        .state = null,
                  ),
                  ...Categoria.values.map(
                    (cat) => _FilterChip(
                      label: cat.label,
                      isActive: selectedCat == cat.name,
                      onTap: () => ref
                          .read(selectedCategoriaProvider.notifier)
                          .state = cat.name,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Results Count ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                cantosAsync.when(
                  data: (cantos) =>
                      '${cantos.length} canto${cantos.length == 1 ? '' : 's'}',
                  loading: () => 'Cargando...',
                  error: (_, __) => 'Error',
                ),
                style: AppTypography.sectionLabel,
              ),
            ),
          ),

          // ─── Cantos List ───
          cantosAsync.when(
            data: (cantos) {
              if (cantos.isEmpty) {
                return const SliverFillRemaining(
                  child: EmptyState(
                    icon: '🎵',
                    title: 'Sin resultados',
                    subtitle:
                        'No se encontraron cantos con ese criterio',
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final canto = cantos[index];
                    return CantoCard(
                      canto: canto,
                      animationIndex: index,
                      onTap: () =>
                          context.push('/cantos/${canto.id}'),
                    );
                  },
                  childCount: cantos.length,
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: isDark
                      ? AppColors.goldLuminous
                      : AppColors.goldDeep,
                  strokeWidth: 2,
                ),
              ),
            ),
            error: (e, _) => SliverFillRemaining(
              child: EmptyState(
                icon: '⚠️',
                title: 'Error',
                subtitle: e.toString(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      // ─── FAB ───
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: AppColors.goldGradient,
          boxShadow: [
            BoxShadow(
              color: (isDark ? AppColors.goldLuminous : AppColors.goldDeep)
                  .withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => context.push(kCantoEditor),
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          child: const Icon(Icons.add_rounded,
              size: 28, color: AppColors.white),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? activeColor
                  : (isDark
                      ? AppColors.darkTextSecondary
                          .withValues(alpha: 0.2)
                      : AppColors.textSecondary
                          .withValues(alpha: 0.2)),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.sans(
                fontSize: 13,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? (isDark ? AppColors.darkBg : AppColors.white)
                    : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojitas_provider.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/hojita_card.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';

class HojitasListPage extends ConsumerWidget {
  const HojitasListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hojitasAsync = ref.watch(hojitasStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // ─── Header ───
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mis Hojitas',
                      style: AppTypography.serif(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hojas de cantos para tus celebraciones',
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
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ─── Hojitas List ───
          hojitasAsync.when(
            data: (hojitas) {
              if (hojitas.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyState(
                    icon: '📋',
                    title: 'Sin hojitas aún',
                    subtitle:
                        'Crea tu primera hojita de cantos para la próxima celebración',
                    actionLabel: 'Crear Hojita',
                    onAction: () => context.push(kHojitaNueva),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Text(
                          'RECIENTES',
                          style: AppTypography.sectionLabel,
                        ),
                      );
                    }
                    final hojita = hojitas[index - 1];
                    return HojitaCard(
                      hojita: hojita,
                      animationIndex: index,
                      onTap: () =>
                          context.push('/hojitas/${hojita.id}/preview'),
                    );
                  },
                  childCount: hojitas.length + 1,
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
          onPressed: () => context.push(kHojitaNueva),
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

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojitas_provider.dart';
import 'package:cantor_app/features/hojitas/presentation/widgets/hojita_card.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';
import 'package:google_fonts/google_fonts.dart';

class HojitasListPage extends ConsumerWidget {
  const HojitasListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hojitasAsync = ref.watch(hojitasStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.navyDeep,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.navyGradient),
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mis Hojitas',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Hojas de cantos para tus celebraciones',
                      style: GoogleFonts.crimsonPro(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
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
                            horizontal: 16, vertical: 4),
                        child: Text(
                          'RECIENTES',
                          style: GoogleFonts.crimsonPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: AppColors.textMuted,
                          ),
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
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
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
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.gold, AppColors.goldLight],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => context.push(kHojitaNueva),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 28, color: AppColors.white),
        ),
      ),
    );
  }
}

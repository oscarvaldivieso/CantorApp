import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/cantos/presentation/widgets/canto_card.dart';
import 'package:cantor_app/shared/widgets/empty_state.dart';
import 'package:google_fonts/google_fonts.dart';

class CantosListPage extends HookConsumerWidget {
  const CantosListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final cantosAsync = ref.watch(cantosFilteredProvider);
    final selectedCat = ref.watch(selectedCategoriaProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.navyDeep,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Cantos',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              centerTitle: true,
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: searchController,
                onChanged: (v) =>
                    ref.read(searchQueryProvider.notifier).state = v,
                style: GoogleFonts.crimsonPro(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Buscar cantos...',
                  hintStyle: GoogleFonts.crimsonPro(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  ),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textMuted),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear,
                              color: AppColors.textMuted),
                          onPressed: () {
                            searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),

          // Category Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CategoryChip(
                    label: 'Todos',
                    isActive: selectedCat == null,
                    onTap: () => ref
                        .read(selectedCategoriaProvider.notifier)
                        .state = null,
                  ),
                  ...Categoria.values.map((cat) => _CategoryChip(
                        label: cat.label,
                        isActive: selectedCat == cat.name,
                        onTap: () => ref
                            .read(selectedCategoriaProvider.notifier)
                            .state = cat.name,
                      )),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Section Label
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                cantosAsync.when(
                  data: (cantos) =>
                      '${cantos.length} CANTO${cantos.length == 1 ? '' : 'S'}',
                  loading: () => 'CARGANDO...',
                  error: (_, __) => 'ERROR',
                ),
                style: GoogleFonts.crimsonPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),

          // Cantos List
          cantosAsync.when(
            data: (cantos) {
              if (cantos.isEmpty) {
                return const SliverFillRemaining(
                  child: EmptyState(
                    icon: '🎵',
                    title: 'Sin resultados',
                    subtitle: 'No se encontraron cantos con ese criterio',
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
                      onTap: () => context.push('/cantos/${canto.id}'),
                    );
                  },
                  childCount: cantos.length,
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
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.navyDeep : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? AppColors.navyDeep : AppColors.parchment,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.crimsonPro(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppColors.white : AppColors.textMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/theme/app_typography.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita_item.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojita_builder_provider.dart';

class CantoSelectorSheet extends HookConsumerWidget {
  const CantoSelectorSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final searchQuery = useState('');
    final selectedCat = useState<String?>(null);
    final cantosAsync = ref.watch(cantosStreamProvider);
    final builder = ref.watch(hojitaBuilderProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBg : AppColors.cream,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkTextSecondary
                          .withValues(alpha: 0.3)
                      : AppColors.textSecondary
                          .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Seleccionar Cantos',
                style: AppTypography.serif(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchCtrl,
                  onChanged: (v) => searchQuery.value = v,
                  style: AppTypography.sans(
                    fontSize: 16,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Buscar cantos...',
                    hintStyle: AppTypography.sans(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Category chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _FilterChip(
                      label: 'Todos',
                      isActive: selectedCat.value == null,
                      onTap: () => selectedCat.value = null,
                    ),
                    ...Categoria.values.map((cat) => _FilterChip(
                          label: cat.label,
                          isActive: selectedCat.value == cat.name,
                          onTap: () => selectedCat.value = cat.name,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Cantos list
              Expanded(
                child: cantosAsync.when(
                  data: (cantos) {
                    var filtered = cantos.toList();
                    if (searchQuery.value.isNotEmpty) {
                      final q = searchQuery.value.toLowerCase();
                      filtered = filtered
                          .where((c) =>
                              c.titulo.toLowerCase().contains(q) ||
                              (c.autor?.toLowerCase().contains(q) ??
                                  false))
                          .toList();
                    }
                    if (selectedCat.value != null) {
                      filtered = filtered
                          .where((c) =>
                              c.categorias.contains(selectedCat.value))
                          .toList();
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final canto = filtered[index];
                        final isSelected = builder.cantos
                            .any((c) => c.cantoUuid == canto.uuid);
                        return _CantoSelectItem(
                          canto: canto,
                          isSelected: isSelected,
                          onToggle: () {
                            if (isSelected) {
                              ref
                                  .read(
                                      hojitaBuilderProvider.notifier)
                                  .removeCanto(canto.uuid);
                            } else {
                              final item = HojitaItem()
                                ..cantoUuid = canto.uuid
                                ..cantoTitulo = canto.titulo
                                ..cantoAutor = canto.autor ?? ''
                                ..cantoCategoria =
                                    canto.categorias.isNotEmpty
                                        ? canto.categorias.first
                                        : 'varios'
                                ..tonalidad = canto.tonalidad;
                              ref
                                  .read(
                                      hojitaBuilderProvider.notifier)
                                  .addCanto(item);
                            }
                          },
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: isDark
                          ? AppColors.goldLuminous
                          : AppColors.goldDeep,
                      strokeWidth: 2,
                    ),
                  ),
                  error: (e, _) =>
                      Center(child: Text(e.toString())),
                ),
              ),

              // Bottom bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBgSecondary
                      : AppColors.surfaceElevated,
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: AppColors.warmShadow
                                .withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, -3),
                          ),
                        ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${builder.cantos.length} canto${builder.cantos.length == 1 ? '' : 's'} seleccionado${builder.cantos.length == 1 ? '' : 's'}',
                          style: AppTypography.sans(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: AppColors.goldGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Listo',
                            style: AppTypography.sans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
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
      },
    );
  }
}

class _CantoSelectItem extends StatelessWidget {
  final Canto canto;
  final bool isSelected;
  final VoidCallback onToggle;

  const _CantoSelectItem({
    required this.canto,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? AppColors.goldLuminous : AppColors.goldDeep;

    return ListTile(
      onTap: onToggle,
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected ? activeColor : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? activeColor
                : (isDark
                    ? AppColors.darkTextSecondary
                        .withValues(alpha: 0.3)
                    : AppColors.textSecondary
                        .withValues(alpha: 0.2)),
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(Icons.check,
                color: isDark ? AppColors.darkBg : AppColors.white,
                size: 16)
            : null,
      ),
      title: Text(
        canto.titulo,
        style: AppTypography.sans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        canto.autor ?? '',
        style: AppTypography.sans(
          fontSize: 12,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
        ),
      ),
      trailing: Text(
        canto.categorias.isNotEmpty
            ? Categoria.values
                    .where(
                        (c) => c.name == canto.categorias.first)
                    .firstOrNull
                    ?.label ??
                canto.categorias.first
            : '',
        style: AppTypography.sans(
          fontSize: 11,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
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
              horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
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
          child: Text(
            label,
            style: AppTypography.sans(
              fontSize: 12,
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
    );
  }
}

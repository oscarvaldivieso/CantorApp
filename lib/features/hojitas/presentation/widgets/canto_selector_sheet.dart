import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/features/cantos/domain/canto.dart';
import 'package:cantor_app/features/cantos/domain/enums.dart';
import 'package:cantor_app/features/cantos/presentation/providers/cantos_provider.dart';
import 'package:cantor_app/features/hojitas/domain/hojita_item.dart';
import 'package:cantor_app/features/hojitas/presentation/providers/hojita_builder_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CantoSelectorSheet extends HookConsumerWidget {
  const CantoSelectorSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final searchQuery = useState('');
    final selectedCat = useState<String?>(null);
    final cantosAsync = ref.watch(cantosStreamProvider);
    final builder = ref.watch(hojitaBuilderProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.parchment,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Seleccionar Cantos',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navyDeep,
                ),
              ),
              const SizedBox(height: 12),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchCtrl,
                  onChanged: (v) => searchQuery.value = v,
                  style: GoogleFonts.crimsonPro(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Buscar cantos...',
                    hintStyle: GoogleFonts.crimsonPro(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
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

              // List
              Expanded(
                child: cantosAsync.when(
                  data: (cantos) {
                    var filtered = cantos.toList();
                    if (searchQuery.value.isNotEmpty) {
                      final q = searchQuery.value.toLowerCase();
                      filtered = filtered
                          .where((c) =>
                              c.titulo.toLowerCase().contains(q) ||
                              (c.autor?.toLowerCase().contains(q) ?? false))
                          .toList();
                    }
                    if (selectedCat.value != null) {
                      filtered = filtered
                          .where((c) => c.categorias.contains(selectedCat.value))
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
                                  .read(hojitaBuilderProvider.notifier)
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
                                  .read(hojitaBuilderProvider.notifier)
                                  .addCanto(item);
                            }
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  ),
                  error: (e, _) => Center(child: Text(e.toString())),
                ),
              ),

              // Bottom bar with count
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.parchment),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${builder.cantos.length} canto${builder.cantos.length == 1 ? '' : 's'} seleccionado${builder.cantos.length == 1 ? '' : 's'}',
                          style: GoogleFonts.crimsonPro(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navyDeep,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Listo',
                          style: GoogleFonts.crimsonPro(
                            fontWeight: FontWeight.w600,
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
    return ListTile(
      onTap: onToggle,
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.navyDeep : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.navyDeep : AppColors.parchment,
            width: 2,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check, color: AppColors.white, size: 16)
            : null,
      ),
      title: Text(
        canto.titulo,
        style: GoogleFonts.crimsonPro(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      subtitle: Text(
        canto.autor ?? '',
        style: GoogleFonts.crimsonPro(
          fontSize: 12,
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
        ),
      ),
      trailing: Text(
        canto.categorias.isNotEmpty
            ? Categoria.values
                .where((c) => c.name == canto.categorias.first)
                .firstOrNull
                ?.label ?? canto.categorias.first
            : '',
        style: GoogleFonts.crimsonPro(
          fontSize: 11,
          color: AppColors.textMuted,
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
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.navyDeep : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? AppColors.navyDeep : AppColors.parchment,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.crimsonPro(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? AppColors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

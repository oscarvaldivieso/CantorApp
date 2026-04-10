import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/core/theme/app_colors.dart';
import 'package:cantor_app/core/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  static int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/cantos')) return 1;
    if (location.startsWith('/hojitas')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.parchment, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: '🏠',
                  label: 'Inicio',
                  isActive: index == 0,
                  onTap: () => context.go(kHome),
                ),
                _NavItem(
                  icon: '🎵',
                  label: 'Cantos',
                  isActive: index == 1,
                  onTap: () => context.go(kCantos),
                ),
                _NavItem(
                  icon: '📋',
                  label: 'Hojitas',
                  isActive: index == 2,
                  onTap: () => context.go(kHojitas),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.crimsonPro(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? AppColors.navyDeep : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isActive ? 4 : 0,
            height: 4,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cantor_app/core/theme/app_theme.dart';
import 'package:cantor_app/core/router/app_router.dart';

class CantorApp extends StatelessWidget {
  const CantorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CantorApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}

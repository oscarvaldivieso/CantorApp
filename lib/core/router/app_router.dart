import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cantor_app/shared/widgets/app_scaffold.dart';
import 'package:cantor_app/features/home/presentation/home_page.dart';
import 'package:cantor_app/features/cantos/presentation/cantos_list_page.dart';
import 'package:cantor_app/features/cantos/presentation/canto_detail_page.dart';
import 'package:cantor_app/features/cantos/presentation/canto_editor_page.dart';
import 'package:cantor_app/features/hojitas/presentation/hojitas_list_page.dart';
import 'package:cantor_app/features/hojitas/presentation/hojita_builder_page.dart';
import 'package:cantor_app/features/hojitas/presentation/hojita_preview_page.dart';

const String kHome = '/';
const String kCantos = '/cantos';
const String kCantoDetail = '/cantos/:id';
const String kCantoEditor = '/cantos/nuevo';
const String kHojitas = '/hojitas';
const String kHojitaNueva = '/hojitas/nueva';
const String kHojitaPreview = '/hojitas/:id/preview';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: kHome,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: kHome,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: kCantos,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CantosListPage(),
          ),
        ),
        GoRoute(
          path: kHojitas,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HojitasListPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: kCantoDetail,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CantoDetailPage(cantoId: id);
      },
    ),
    GoRoute(
      path: kCantoEditor,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CantoEditorPage(),
    ),
    GoRoute(
      path: kHojitaNueva,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HojitaBuilderPage(),
    ),
    GoRoute(
      path: kHojitaPreview,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return HojitaPreviewPage(hojitaId: id);
      },
    ),
  ],
);

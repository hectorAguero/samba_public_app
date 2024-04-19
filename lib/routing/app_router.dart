import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../common_widgets/cupertino_sheet.dart';
import '../core/providers/initialization_provider.dart';
import '../features/home/home_page.dart';
import '../features/home/home_page_controller.dart';
import '../features/instruments/details/instrument_details_page.dart';
import '../features/instruments/instruments_tab_page.dart';
import '../features/parades/parades_tab_page.dart';
import '../features/schools/details/school_details_page.dart';
import '../features/schools/schools_tab_page.dart';
import '../initialization.dart';

part 'app_router.g.dart';

/// Required by StatefulShellRoute in GoRouter
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final controllers = IMap(
    {for (final tab in HomeTab.values) tab.name: ScrollController()},
  );
  final initProvider = ref.watch(initializationProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomeTab.instruments.path,
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: Scaffold(body: Text('404 - Not Found')),
    ),
    redirect: (context, state) {
      if (initProvider.isLoading) {
        return InitializationPage.path;
      }
      if (initProvider.hasError) {
        return InitializationPage.path;
      }
      final path = state.fullPath?.split('/');
      final topPath = path?.sublist(0, 2).join('/');
      if (path != null && HomeTab.values.any((v) => v.path == topPath)) {
        final home = ref.read(currentTabProvider);
        final nextTab = HomeTab.values.firstWhere(
          (t) => t.path == topPath,
        );
        final top = path.length <= 2;
        if (home.tab.path != nextTab.path || home.topRoute != top) {
          Future.microtask(
            () => ref.read(currentTabProvider.notifier).set(nextTab, top: top),
          );
        }
        if (home.tab.path == nextTab.path && home.topRoute == top) {
          Future.microtask(
            () => _scrollTabToTheTop(controllers[nextTab.name]!),
          );
        }

        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: InitializationPage.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: InitializationPage(
            // * Just a placeholder, route will be managed by GoRouter
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (_, __, shell) => NoTransitionPage(child: HomePage(shell)),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: InstrumentsTabPage.path,
                builder: (_, __) => PrimaryScrollController(
                  controller: controllers[InstrumentsTabPage.tab.name]!,
                  child: const InstrumentsTabPage(),
                ),
                routes: [
                  GoRoute(
                    path: InstrumentDetailsPage.path,
                    onExit: (context) {
                      Future.microtask(
                        () => ref
                            .read(currentTabProvider.notifier)
                            .set(InstrumentsTabPage.tab, top: true),
                      );
                      return Future.value(true);
                    },
                    builder: (_, state) => InstrumentDetailsPage(
                      id: int.parse(state.pathParameters['id']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ParadesTabPage.path,
                builder: (_, __) => PrimaryScrollController(
                  controller: controllers[ParadesTabPage.tab.name]!,
                  child: const ParadesTabPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SchoolsTabPage.path,
                builder: (context, state) {
                  return PrimaryScrollController(
                    controller: controllers[SchoolsTabPage.tab.name]!,
                    child: const SchoolsTabPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: SchoolDetailsPage.path,
                    pageBuilder: (context, state) {
                      return AppCupertinoSheetPage(
                        child: SchoolDetailsPage(
                          id: int.parse(state.pathParameters['id']!),
                        ),
                      );
                    },
                    onExit: (context) {
                      Future.microtask(
                        () => ref
                            .read(currentTabProvider.notifier)
                            .set(SchoolsTabPage.tab, top: true),
                      );
                      return Future.value(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

void _scrollTabToTheTop(ScrollController controller) {
  if (controller.hasClients) {
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }
}
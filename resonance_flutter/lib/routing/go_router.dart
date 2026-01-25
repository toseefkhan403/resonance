import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:resonance_flutter/application/auth_service.dart';
import 'package:resonance_flutter/application/graph_service.dart';
import 'package:resonance_flutter/presentation/force_directed_graph_page.dart';
import 'package:resonance_flutter/presentation/home_page.dart';
import 'package:resonance_flutter/presentation/sign_in_page.dart';
import 'package:resonance_flutter/presentation/unknown_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authService.authInfoListenable,
    redirect: (context, GoRouterState state) async {
      try {
        final isLoggedIn = authService.isAuthenticated;

        final isOnSignIn = state.matchedLocation == '/';
        final isProtectedRoute =
            state.matchedLocation == '/home' ||
            state.matchedLocation == '/graph';

        debugPrint(
          'redirect → isLoggedIn=$isLoggedIn, route=${state.matchedLocation}',
        );

        if (!isLoggedIn && isProtectedRoute) {
          return '/';
        }

        if (isLoggedIn && isOnSignIn) {
          final graphService = ref.read(graphServiceProvider);
          // todo_move this to a lighter method
          final graphData = await graphService.getGraphData();
          if (graphData.graphWithGranularity.isNotEmpty) {
            return '/graph';
          }
          return '/home';
        }
      } catch (e) {
        debugPrint('Error in redirect: $e');
      }

      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: AppRoute.signIn.name,
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/graph',
        name: AppRoute.graph.name,
        builder: (context, state) {
          return const ForceDirectedGraphPage();
        },
      ),
      GoRoute(
        path: '/demo-graph',
        name: AppRoute.demoGraph.name,
        builder: (context, state) {
          return const ForceDirectedGraphPage(isDemo: true);
        },
      ),
      GoRoute(
        path: '/unknown',
        name: AppRoute.unknown.name,
        builder: (context, state) => const UnknownPage(),
      ),
    ],
    onException: (context, state, error) {
      debugPrint('Error in router: $error');
    },
    debugLogDiagnostics: true,
  );
}

enum AppRoute {
  home,
  demoGraph,
  graph,
  signIn,
  unknown,
}

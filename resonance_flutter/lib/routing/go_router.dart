// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:resonance_flutter/application/auth_service.dart';
import 'package:resonance_flutter/presentation/home_page.dart';
import 'package:resonance_flutter/presentation/sign_in_page.dart';
import 'package:resonance_flutter/presentation/unknown_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, GoRouterState state) async {
      try {
        // login and logout rebuilds the router and brings to /
        final authState = ref.watch(authStateChangesProvider);
        final uid = authState.asData?.value?.authUserId;
        final isLoggedIn = uid != null;

        debugPrint('isLoggedIn: $isLoggedIn');
        final isRoot = state.matchedLocation == '/';
        final isHome = state.matchedLocation == '/home';

        if (isRoot) {
          if (isLoggedIn) return '/home';
        } else if (isHome) {
          if (!isLoggedIn) return '/';
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
  signIn,
  unknown,
}

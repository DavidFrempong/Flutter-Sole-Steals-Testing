import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solesteals/presentation/screens/home_screen.dart';
import 'package:solesteals/presentation/screens/splash_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(path: '/'),
    ),
    GoRoute(
      name: 'homeWithPath',
      path: '/homeWithPath/:path',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: HomeScreen(path: state.params['path'] ?? '/'),
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

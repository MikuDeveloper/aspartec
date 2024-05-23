import 'package:aspartec/view/home/home_view.dart';
import 'package:aspartec/view/login/login_view.dart';
import 'package:aspartec/view/profile/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginView.routeName,
      builder: (context, state) => const LoginView()
    ),
    GoRoute(
      path: '/home',
      name: HomeView.routeName,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1,0), end: Offset.zero)
            ),
            child: child,
          ),
        child: const HomeView()
      ),
      routes: [
        GoRoute(
          path: 'profile',
          name: ProfileView.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child
              ),
            child: const ProfileView()
          ),
        )
      ]
    )
  ]
);
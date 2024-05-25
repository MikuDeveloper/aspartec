import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../controller/home/home_controller.dart';
import '../view/login/login_view.dart';
import '../view/profile/profile_view.dart';

final routerConfig = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginView.routeName,
      builder: (context, state) => const LoginView(),
      redirect: (context, state) {
        return FirebaseAuth.instance.currentUser?.email == null ? '/login' : '/home';
      }
    ),
    GoRoute(
      path: '/home',
      name: HomeController.routeName,
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
        child: const HomeController()
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
  ],
  redirect: (context, state) {
    return FirebaseAuth.instance.currentUser?.email == null ? '/login' : null;
  }
);
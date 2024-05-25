import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../controller/home/home_controller.dart';
import '../model/entities/user_entity.dart';
import '../view/login/login_view.dart';
import '../view/profile/profile_view.dart';
import '../view/profile/update_avatar_view.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
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
          pageBuilder: (context, state) {
            final Map<String, dynamic> extra = state.extra! as Map<String, dynamic>;
            final user = extra['user'] as UserEntity;
            return CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child
                ),
              child: ProfileView(user: user)
            );
          },
          routes: [
            GoRoute(
              path: 'update-avatar',
              name: UpdateAvatarView.routeName,
              pageBuilder: (context, state) {
                final Map<String, dynamic> extra = state.extra! as Map<String, dynamic>;
                final user = extra['user'] as UserEntity;

                return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: animation.drive(
                        Tween(begin: const Offset(1,0), end: Offset.zero)
                      ),
                      child: child,
                    ),
                  child: UpdateAvatarView(user: user)
                );
              },
            )
          ]
        )
      ]
    )
  ],
  redirect: (context, state) {
    return FirebaseAuth.instance.currentUser?.email == null ? '/login' : null;
  }
);
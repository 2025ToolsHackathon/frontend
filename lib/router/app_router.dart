import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/alarm_flow_option.dart';
import '../screens/challenge/challenge_screen.dart';
import '../screens/challenge/result_screen.dart';
import '../screens/dashboard/main_dashboard_screen.dart';
import '../screens/onboarding/alarm_option_screen.dart';
import '../screens/onboarding/alarm_time_picker_screen.dart';
import '../screens/onboarding/alarm_time_suggestion_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/team/team_dashboard_screen.dart';
import '../screens/team/team_join_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashScreen.routePath,
    routes: [
      GoRoute(
        path: SplashScreen.routePath,
        name: SplashScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AlarmOptionScreen.routePath,
        name: AlarmOptionScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const AlarmOptionScreen(),
        ),
      ),
      GoRoute(
        path: AlarmTimePickerScreen.routePath,
        name: AlarmTimePickerScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: AlarmTimePickerScreen(option: state.extra as AlarmFlowOption?),
        ),
      ),
      GoRoute(
        path: AlarmTimeSuggestionScreen.routePath,
        name: AlarmTimeSuggestionScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: state.extra is AlarmSuggestionArguments
              ? AlarmTimeSuggestionScreen.fromArgs(state.extra as AlarmSuggestionArguments)
              : AlarmTimeSuggestionScreen(
                  baseTime: DateTime.now(),
                  suggestions: const [],
                ),
        ),
      ),
      GoRoute(
        path: MainDashboardScreen.routePath,
        name: MainDashboardScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const MainDashboardScreen(),
        ),
      ),
      GoRoute(
        path: ChallengeScreen.routePath,
        name: ChallengeScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const ChallengeScreen(),
        ),
      ),
      GoRoute(
        path: ChallengeResultScreen.routePath,
        name: ChallengeResultScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: ChallengeResultScreen(
            success: state.uri.queryParameters['success'] == 'true',
          ),
        ),
      ),
      GoRoute(
        path: TeamDashboardScreen.routePath,
        name: TeamDashboardScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const TeamDashboardScreen(),
        ),
      ),
      GoRoute(
        path: TeamJoinScreen.routePath,
        name: TeamJoinScreen.routeName,
        pageBuilder: (context, state) => _buildPage(
          key: state.pageKey,
          child: const TeamJoinScreen(),
        ),
      ),
    ],
  );
});

CustomTransitionPage<dynamic> _buildPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<dynamic>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}


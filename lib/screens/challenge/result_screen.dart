import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../dashboard/main_dashboard_screen.dart';

class ChallengeResultScreen extends StatelessWidget {
  const ChallengeResultScreen({super.key, required this.success});

  static const routeName = 'challenge-result';
  static const routePath = '/challenge/result';

  final bool success;

  @override
  Widget build(BuildContext context) {
    final title = success ? '인증 성공!' : '인증 실패';
    final subtitle = success ? '+100 LP가 적립되었습니다.' : '-10 LP가 차감되었습니다.';
    final icon = success ? Icons.check_circle_outline : Icons.error_outline;
    final iconColor = success ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(title: const Text('챌린지 결과')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 120),
            const SizedBox(height: 24),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(subtitle, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go(MainDashboardScreen.routePath),
              child: const Text('대시보드로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}


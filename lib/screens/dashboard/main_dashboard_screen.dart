import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/alarm_settings_provider.dart';
import '../../providers/user_provider.dart';
import '../challenge/challenge_screen.dart';
import '../onboarding/alarm_option_screen.dart';
import '../team/team_dashboard_screen.dart';

class MainDashboardScreen extends ConsumerWidget {
  const MainDashboardScreen({super.key});

  static const routeName = 'main-dashboard';
  static const routePath = '/dashboard';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmState = ref.watch(alarmSettingsProvider);
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PoseUp'),
        actions: [
          IconButton(
            onPressed: () => context.push(TeamDashboardScreen.routePath),
            icon: const Icon(Icons.group),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('안녕하세요, ${userState.displayName ?? 'PoseUp 챌린저'}님!',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            _CharacterCard(lp: userState.lp),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                title: const Text('내일 알람 시간'),
                subtitle: Text(alarmState.formattedAlarmTime ?? '아직 설정되지 않았습니다'),
                trailing: const Icon(Icons.alarm),
                onTap: () => context.push(AlarmOptionScreen.routePath),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.push(ChallengeScreen.routePath),
                  icon: const Icon(Icons.fitness_center),
                  label: const Text('오늘의 포즈 챌린지로 이동'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({required this.lp});

  final int lp;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              child: Icon(Icons.self_improvement, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Life Point: $lp', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (lp % 1000) / 1000,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 4),
                  const Text('다음 성장까지 1000 LP')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


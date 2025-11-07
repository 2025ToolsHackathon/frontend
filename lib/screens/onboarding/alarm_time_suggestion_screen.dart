import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../providers/alarm_settings_provider.dart';
import '../dashboard/main_dashboard_screen.dart';

class AlarmSuggestionArguments {
  AlarmSuggestionArguments({
    required this.baseTime,
    required this.suggestedWakeUpTimes,
  });

  final DateTime baseTime;
  final List<DateTime> suggestedWakeUpTimes;
}

class AlarmTimeSuggestionScreen extends ConsumerWidget {
  const AlarmTimeSuggestionScreen({super.key, required this.baseTime, required this.suggestions});

  static const routeName = 'alarm-time-suggestions';
  static const routePath = '/onboarding/alarm-time-suggestions';

  final DateTime baseTime;
  final List<DateTime> suggestions;

  factory AlarmTimeSuggestionScreen.fromArgs(AlarmSuggestionArguments args) {
    return AlarmTimeSuggestionScreen(
      baseTime: args.baseTime,
      suggestions: args.suggestedWakeUpTimes,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('기상 시간 제안')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '선택한 취침 시간: ${DateFormat('a h:mm', 'ko_KR').format(baseTime)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '추천 기상 시간',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...suggestions.map((time) => _SuggestionTile(
                  label: DateFormat('a h:mm', 'ko_KR').format(time),
                  onTap: () {
                    ref.read(alarmSettingsProvider.notifier).setFinalAlarmTime(time);
                    context.go(MainDashboardScreen.routePath);
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}


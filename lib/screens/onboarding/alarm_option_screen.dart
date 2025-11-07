import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/alarm_flow_option.dart';
import 'alarm_time_picker_screen.dart';

class AlarmOptionScreen extends StatelessWidget {
  const AlarmOptionScreen({super.key});

  static const routeName = 'alarm-option';
  static const routePath = '/onboarding/alarm-option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알람 설정 방식')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '어떻게 알람을 설정할까요?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _OptionCard(
              title: '일어날 시간을 정할래요',
              description: '기상 시간을 기준으로 수면 사이클을 추천해드려요.',
              onTap: () => context.push(
                AlarmTimePickerScreen.routePath,
                extra: AlarmFlowOption.wakeUpTime,
              ),
            ),
            const SizedBox(height: 16),
            _OptionCard(
              title: '잘 시간을 정할래요',
              description: '취침 시간을 기준으로 기상 시간을 제안해드려요.',
              onTap: () => context.push(
                AlarmTimePickerScreen.routePath,
                extra: AlarmFlowOption.sleepTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}


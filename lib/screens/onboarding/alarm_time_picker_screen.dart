import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/alarm_flow_option.dart';
import '../../providers/alarm_settings_provider.dart';
import '../../services/sleep_cycle_service.dart';
import '../dashboard/main_dashboard_screen.dart';
import 'alarm_time_suggestion_screen.dart';

class AlarmTimePickerScreen extends ConsumerStatefulWidget {
  const AlarmTimePickerScreen({super.key, this.option});

  final AlarmFlowOption? option;

  static const routeName = 'alarm-time-picker';
  static const routePath = '/onboarding/alarm-time-picker';

  @override
  ConsumerState<AlarmTimePickerScreen> createState() => _AlarmTimePickerScreenState();
}

class _AlarmTimePickerScreenState extends ConsumerState<AlarmTimePickerScreen> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final option = widget.option ?? AlarmFlowOption.wakeUpTime;
    final now = DateTime.now();
    final displayTime = DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
    final timeLabel = DateFormat('a h:mm', 'ko_KR').format(displayTime);

    return Scaffold(
      appBar: AppBar(title: Text(option == AlarmFlowOption.wakeUpTime ? '기상 시간 선택' : '취침 시간 선택')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              timeLabel,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: _showTimePicker,
              icon: const Icon(Icons.access_time),
              label: const Text('시간 선택'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _onNextPressed(option),
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _onNextPressed(AlarmFlowOption option) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final sleepService = SleepCycleService();

    if (option == AlarmFlowOption.wakeUpTime) {
      ref.read(alarmSettingsProvider.notifier).setFinalAlarmTime(selectedDateTime);
      context.go(MainDashboardScreen.routePath);
      return;
    }

    final suggestions = sleepService.calculateWakeUpSuggestions(selectedDateTime);

    context.push(
      AlarmTimeSuggestionScreen.routePath,
      extra: AlarmSuggestionArguments(
        baseTime: selectedDateTime,
        suggestedWakeUpTimes: suggestions,
      ),
    );
  }
}


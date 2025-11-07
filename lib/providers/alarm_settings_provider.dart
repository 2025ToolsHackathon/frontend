import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AlarmSettingsState {
  const AlarmSettingsState({this.finalAlarmTime});

  final DateTime? finalAlarmTime;

  String? get formattedAlarmTime {
    if (finalAlarmTime == null) return null;
    return DateFormat('a h:mm', 'ko_KR').format(finalAlarmTime!);
  }

  AlarmSettingsState copyWith({DateTime? finalAlarmTime}) {
    return AlarmSettingsState(
      finalAlarmTime: finalAlarmTime ?? this.finalAlarmTime,
    );
  }
}

class AlarmSettingsNotifier extends StateNotifier<AlarmSettingsState> {
  AlarmSettingsNotifier() : super(const AlarmSettingsState());

  void setFinalAlarmTime(DateTime alarmTime) {
    state = state.copyWith(finalAlarmTime: alarmTime);
  }

  void clear() {
    state = const AlarmSettingsState();
  }
}

final alarmSettingsProvider = StateNotifierProvider<AlarmSettingsNotifier, AlarmSettingsState>((ref) {
  return AlarmSettingsNotifier();
});


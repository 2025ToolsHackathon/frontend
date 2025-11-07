class SleepCycleService {
  /// 취침 시간을 기준으로 평균 잠드는 시간(15분)을 고려한 후
  /// 90분 주기의 기상 시간 제안을 계산합니다.
  List<DateTime> calculateWakeUpSuggestions(DateTime sleepTime) {
    final fallAsleepTime = sleepTime.add(const Duration(minutes: 15));

    return [
      fallAsleepTime.add(const Duration(hours: 6)),
      fallAsleepTime.add(const Duration(hours: 7, minutes: 30)),
      fallAsleepTime.add(const Duration(hours: 9)),
    ];
  }
}


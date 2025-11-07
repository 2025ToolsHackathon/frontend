class TeamMember {
  const TeamMember({
    required this.id,
    required this.name,
    this.weeklySuccessCount = 0,
    this.todaySuccess = false,
  });

  final String id;
  final String name;
  final int weeklySuccessCount;
  final bool todaySuccess;

  TeamMember copyWith({
    String? id,
    String? name,
    int? weeklySuccessCount,
    bool? todaySuccess,
  }) {
    return TeamMember(
      id: id ?? this.id,
      name: name ?? this.name,
      weeklySuccessCount: weeklySuccessCount ?? this.weeklySuccessCount,
      todaySuccess: todaySuccess ?? this.todaySuccess,
    );
  }
}


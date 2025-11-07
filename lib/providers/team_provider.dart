import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/team_member.dart';

class TeamState {
  const TeamState({
    this.teamId,
    this.teamName,
    this.teamLp = 0,
    this.members = const [],
  });

  final String? teamId;
  final String? teamName;
  final int teamLp;
  final List<TeamMember> members;

  TeamState copyWith({
    String? teamId,
    String? teamName,
    int? teamLp,
    List<TeamMember>? members,
  }) {
    return TeamState(
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamLp: teamLp ?? this.teamLp,
      members: members ?? this.members,
    );
  }
}

class TeamNotifier extends StateNotifier<TeamState> {
  TeamNotifier()
      : super(const TeamState(
          members: [
            TeamMember(id: '1', name: 'Alice', weeklySuccessCount: 5, todaySuccess: true),
            TeamMember(id: '2', name: 'Bob', weeklySuccessCount: 4, todaySuccess: false),
            TeamMember(id: '3', name: 'Charlie', weeklySuccessCount: 3, todaySuccess: true),
          ],
        ));

  void createTeam(String teamName) {
    state = state.copyWith(
      teamId: 'team-${DateTime.now().millisecondsSinceEpoch}',
      teamName: teamName,
      teamLp: 1000,
    );
  }

  void joinTeam(String inviteCode) {
    state = state.copyWith(
      teamId: inviteCode,
      teamName: '초대받은 팀',
      teamLp: 750,
    );
  }
}

final teamProvider = StateNotifierProvider<TeamNotifier, TeamState>((ref) {
  return TeamNotifier();
});


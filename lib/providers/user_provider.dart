import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  const UserState({
    this.uid,
    this.displayName,
    this.lp = 0,
  });

  final String? uid;
  final String? displayName;
  final int lp;

  UserState copyWith({String? uid, String? displayName, int? lp}) {
    return UserState(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      lp: lp ?? this.lp,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(displayName: '게스트', lp: 520));

  void setUser(String uid, String? displayName) {
    state = state.copyWith(uid: uid, displayName: displayName);
  }

  void updateLp(int delta) {
    state = state.copyWith(lp: (state.lp + delta).clamp(0, 99999));
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});


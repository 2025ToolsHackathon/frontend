import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/team_provider.dart';
import 'team_join_screen.dart';

class TeamDashboardScreen extends ConsumerWidget {
  const TeamDashboardScreen({super.key});

  static const routeName = 'team-dashboard';
  static const routePath = '/team';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('팀 현황')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(TeamJoinScreen.routePath),
        label: const Text('팀 참여/생성'),
        icon: const Icon(Icons.group_add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('팀 이름: ${teamState.teamName ?? '미가입'}',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('팀 LP'),
                subtitle: Text('${teamState.teamLp} LP'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('팀원 목록', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: teamState.members.length,
                itemBuilder: (context, index) {
                  final member = teamState.members[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(member.name),
                      subtitle: Text('주간 성공 ${member.weeklySuccessCount}회'),
                      trailing: Icon(
                        member.todaySuccess ? Icons.check_circle : Icons.cancel,
                        color: member.todaySuccess ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


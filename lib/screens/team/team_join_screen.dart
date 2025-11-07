import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/team_provider.dart';

class TeamJoinScreen extends ConsumerStatefulWidget {
  const TeamJoinScreen({super.key});

  static const routeName = 'team-join';
  static const routePath = '/team/join';

  @override
  ConsumerState<TeamJoinScreen> createState() => _TeamJoinScreenState();
}

class _TeamJoinScreenState extends ConsumerState<TeamJoinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();

  @override
  void dispose() {
    _teamNameController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamNotifier = ref.read(teamProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('팀 생성 / 참여')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('팀 생성', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _teamNameController,
                decoration: const InputDecoration(labelText: '팀 이름'),
                validator: (value) => value == null || value.isEmpty ? '팀 이름을 입력하세요' : null,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    teamNotifier.createTeam(_teamNameController.text);
                    context.pop();
                  }
                },
                child: const Text('팀 생성하기'),
              ),
              const Divider(height: 48),
              const Text('팀 참여', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _inviteCodeController,
                decoration: const InputDecoration(labelText: '참여 코드'),
                validator: (value) => value == null || value.isEmpty ? '참여 코드를 입력하세요' : null,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    teamNotifier.joinTeam(_inviteCodeController.text);
                    context.pop();
                  }
                },
                child: const Text('팀 참여하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


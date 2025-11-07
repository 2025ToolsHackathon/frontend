import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'result_screen.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  static const routeName = 'challenge';
  static const routePath = '/challenge';

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  static const Duration challengeDuration = Duration(minutes: 5);
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().add(challengeDuration);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _endTime.difference(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 포즈 챌린지')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('남은 시간: ${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}'),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    '카메라 미리보기 자리',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('오늘의 미션 포즈'),
                subtitle: const Text('포즈 가이드 이미지를 여기에 표시'),
                trailing: const Icon(Icons.image_outlined),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go('${ChallengeResultScreen.routePath}?success=true'),
                    child: const Text('임시 성공 처리'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('${ChallengeResultScreen.routePath}?success=false'),
                    child: const Text('임시 실패 처리'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


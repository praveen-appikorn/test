import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'package:test/home/screens/home_screen.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(ref.watch(incProvider).toString()),
                IconButton(
                  onPressed: () {
                    ref.watch(incProvider.notifier).update(
                          (state) => state + 1,
                        );
                  },
                  icon: const Icon(Icons.plus_one),
                ),
              ],
            ),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Routemaster.of(context).pop();
                  },
                  child: const Text("Back ⬅️"),
                ),
                OutlinedButton(
                  onPressed: () {
                    Routemaster.of(context).push('/third');
                  },
                  child: const Text("Next Screen ➡️"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

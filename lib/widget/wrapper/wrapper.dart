import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishiz/widget/wrapper/wrapper_state.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wrapperState = ref.watch(wrapperStateProvider);

    if (wrapperState.stage == WrapperStage.initial) {
      Future.delayed(const Duration(seconds: 1), checkForPrivateKey).then(
        (hasKey) => ref.read(wrapperStateProvider.notifier).keyFound(hasKey),
      );
    }

    if (wrapperState.stage == WrapperStage.initial) {
      return const Scaffold(
        body: Center(
          child: Text('Checking for private key...'),
        ),
      );
    } else if (wrapperState.stage == WrapperStage.hasKey) {
      return const Scaffold(
        body: Center(
          child: Text('Has key'),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text('No key'),
        ),
      );
    }
  }

  Future<bool> checkForPrivateKey() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final privateKey = sharedPreferences.get('privateKey');
    return (privateKey != null);
  }
}

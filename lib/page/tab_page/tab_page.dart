import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/page/home_page.dart';
import 'package:wishiz/page/login_page/login_page.dart';
import 'package:wishiz/page/settings_page.dart';
import 'package:wishiz/page/tab_page/tab_page_state.dart';
import 'package:wishiz/provider/auth_state.dart';

class TabPage extends ConsumerWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();

    final authState = ref.watch(authStateProvider);

    if (authState == AuthStateEnum.waiting) {
      return Container();
    }

    if (authState == AuthStateEnum.notLoggedIn) {
      return LoginPage();
    }

    final tabIndex = ref.watch(tabPageStateNotifierProvider);

    return Scaffold(
      body: tabIndex == 0 ? const HomePage() : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (value) =>
            ref.read(tabPageStateNotifierProvider.notifier).set(value),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.t.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.t.settings,
          ),
        ],
      ),
    );
  }
}

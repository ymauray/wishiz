import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/page/home_page.dart';
import 'package:wishiz/page/login_page/login_page.dart';
import 'package:wishiz/page/settings_page.dart';
import 'package:wishiz/page/tab_page/tab_page_state.dart';
import 'package:wishiz/provider/auth_state.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/item_form.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<void>(
            useRootNavigator: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Center(
                  child: AppName(
                    text: context.t.newItem,
                    fontSize: 30,
                  ),
                ),
                content: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const ItemForm(),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
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

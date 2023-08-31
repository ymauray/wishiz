import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/page/tab_page/tab_page.dart';
import 'package:wishiz/provider/firebase_service.dart';
import 'package:wishiz/service/firebase_service.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/widget_utils.dart';

class SettingsPage extends ConsumerWidget with WidgetUtils {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const AppName(
              fontSize: 30,
            ),
          ),
          body: Column(
            children: [
              FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final info = snapshot.data as PackageInfo;
                    return Center(
                      child: Text(
                        'Version ${info.version} (${info.buildNumber})',
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const Spacer(),
              ListTile(
                title: Center(
                  child: Text(context.t.logout),
                ),
                onTap: () => logout(context, ref),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context, WidgetRef ref) async {
    final response = await ref.read(firebaseServiceProvider).logout();
    if (response.status == ResponseStatus.success) {
      successSnack(context, context.t.successfullyLoggedOut);
      resetNavigation(context, (context) => const TabPage());
    } else {
      errorSnack(context, firebaseErrorMessage(context, response));
    }
  }
}

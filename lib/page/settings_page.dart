import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/page/login_page/login_page.dart';
import 'package:wishiz/provider/firebase_service.dart';
import 'package:wishiz/service/firebase_service_response.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/app_scaffold.dart';
import 'package:wishiz/widget/widget_utils.dart';

class SettingsPage extends ConsumerWidget with WidgetUtils {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
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
    );
  }

  Future<void> logout(BuildContext context, WidgetRef ref) async {
    final response = await ref.read(firebaseServiceProvider).logout();
    if (response.status == FirebaseServiceResponseStatus.success) {
      resetNavigation(context, (context) => LoginPage());
    } else {
      errorSnack(context, firebaseErrorMessage(context, response));
    }
  }
}

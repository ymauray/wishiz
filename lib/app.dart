import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishiz/app_theme.dart';
import 'package:wishiz/page/login_page/login_page.dart';
import 'package:wishiz/provider/auth_state.dart';
import 'package:wishiz/provider/shared_preferences_service.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late StreamSubscription<String> _intentTextDataStreamSubscription;
  String? _sharedText;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      ref.read(authStateProvider.notifier).setUser(user);
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentTextDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen(
      (String value) {
        setState(() {
          _sharedText = value;
          debugPrint('ReceiveSharingIntent.getTextStream : $_sharedText');
        });
      },
      onError: (err) {
        debugPrint('ReceiveSharingIntent.getTextStream error: $err');
      },
    );

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value;
        debugPrint('ReceiveSharingIntent.getInitialText : $_sharedText');
      });
    });
  }

  @override
  void dispose() {
    _intentTextDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build : sharedText : $_sharedText');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme().themeData(context),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ref
                .read(sharedPreferencesServiceProvider)
                .sharedPreferencesInstance = snapshot.data as SharedPreferences;
            FlutterNativeSplash.remove();
            return LoginPage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

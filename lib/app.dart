import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishiz/app_theme.dart';
import 'package:wishiz/page/tab_page/tab_page.dart';
import 'package:wishiz/provider/auth_state.dart';
import 'package:wishiz/provider/shared_preferences_service.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  //late StreamSubscription<List<SharedMediaFile>>
  //    _intentMediaDataStreamSubscription;
  late StreamSubscription<String> _intentTextDataStreamSubscription;
  //List<SharedMediaFile>? _sharedFiles;
  String? _sharedText;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      ref.read(authStateProvider.notifier).setUser(user);
    });

    //// For sharing images coming from outside the app while the app is in the memory
    //_intentMediaDataStreamSubscription =
    //    ReceiveSharingIntent.getMediaStream().listen(
    //  (List<SharedMediaFile> value) {
    //    setState(() {
    //      _sharedFiles = value;
    //      print(
    //        "ReceiveSharingIntent.getMediaStream : ${_sharedFiles?.map((f) => f.path).join(",") ?? ""}",
    //      );
    //    });
    //  },
    //  onError: (err) {
    //    print('ReceiveSharingIntent.getMediaStream error: $err');
    //  },
    //);

    //// For sharing images coming from outside the app while the app is closed
    //ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
    //  setState(() {
    //    _sharedFiles = value;
    //    print(
    //      "ReceiveSharingIntent.getInitialMedia : ${_sharedFiles?.map((f) => f.path).join(",") ?? ""}",
    //    );
    //  });
    //});

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentTextDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen(
      (String value) {
        setState(() {
          _sharedText = value;
          print('ReceiveSharingIntent.getTextStream : $_sharedText');
        });
      },
      onError: (err) {
        print('ReceiveSharingIntent.getTextStream error: $err');
      },
    );

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value;
        print('ReceiveSharingIntent.getInitialText : $_sharedText');
      });
    });

    //ReceiveSharingIntent.getTextStreamAsUri().listen(
    //  (Uri value) {
    //    setState(() {
    //      _sharedText = value.toString();
    //      print('ReceiveSharingIntent.getTextStreamAsUri : $_sharedText');
    //    });
    //  },
    //  onError: (err) {
    //    print('ReceiveSharingIntent.getTextStreamAsUri error: $err');
    //  },
    //);

    //ReceiveSharingIntent.getInitialTextAsUri().then((Uri? value) {
    //  setState(() {
    //    _sharedText = value?.toString();
    //    print('ReceiveSharingIntent.getInitialTextAsUri : $_sharedText');
    //  });
    //});
  }

  @override
  void dispose() {
    //_intentMediaDataStreamSubscription.cancel();
    _intentTextDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build : sharedText : $_sharedText');
    //debugPrint(
    //  "build : sharedFiles : ${_sharedFiles?.map((f) => f.path).join(",") ?? ""}",
    //);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates
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
            return const TabPage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

import 'package:dartsv/dartsv.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishiz/app.dart';
import 'package:wishiz/firebase_options.dart';
import 'package:wishiz/util.dart' as util;

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  GoogleFonts.config.allowRuntimeFetching = false;

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  final mnemonic = Mnemonic(wordList: Wordlist.FRENCH);
  //final seed = await mnemonic.generateMnemonic2(
  //  (wordlist, wordListName) async {
  //    final content = rootBundle
  //        .loadString('assets/dartsv/bip39/wordlists/$wordListName.txt');
  //    return content;
  //  },
  //);
  const phrase =
      'endiguer malaxer antidote taureau emporter glisser devancer armoire coyote mignon irradier éléphant';
  final seed = mnemonic.toSeedHex(phrase, 'gscmmj12');
  final privateKey = HDPrivateKey.fromSeed(seed, NetworkType.TEST);
  final prvk = privateKey.deriveChildNumber(0);
  debugPrint(prvk.toString());
  debugPrint(prvk.publicKey.toString());
  final sendPrvk = prvk.privateKey;
  final sendPubk = prvk.publicKey;
  debugPrint(sendPrvk.toString());
  debugPrint(sendPubk.toString());

  debugPrint(util.secondsToCustomString());

  runApp(const ProviderScope(child: App()));
}

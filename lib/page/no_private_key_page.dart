import 'dart:convert';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wishiz/page/new_key_page.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/app_scaffold.dart';

class NoPrivateKeyPage extends ConsumerWidget {
  const NoPrivateKeyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize a 16 bytes Uint8List with random values
    final iv = Uint8List.fromList(
      List.generate(16, (index) => Random.secure().nextInt(256)),
    );
    final key = Uint8List.fromList(
      List.generate(32, (index) => Random.secure().nextInt(256)),
    );
    final ivHex = hex.encode(iv);
    final keyHex = hex.encode(key);
    final payload = {
      'iv': ivHex,
      'key': keyHex,
      'hash': (ivHex + keyHex).hashCode,
    };
    final data = jsonEncode(payload);
    debugPrint('data : $data');

    return AppScaffold(
      appBar: AppBar(
        title: const AppName(
          fontSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'QR Code',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Ce QR Code vous permet de partager votre liste de souhaits avec vos amis. Il suffit qu'ils le scannent dans l'application sur leur propre appareil. Vous pouvez aussi envoyer une photo du code qu'ils ouvriront dans leur application, même si cette méthode est moins sécurisée.",
              ),
              const SizedBox(
                height: 16,
              ),
              QrImageView(
                data: data,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: Colors.white,
                ),
                gapless: false,
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (context) => NewKeyPage(),
                    ),
                  );
                },
                child: const Text('Compris !'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

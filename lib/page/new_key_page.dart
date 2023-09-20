import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/app_scaffold.dart';

class NewKeyPage extends ConsumerWidget {
  NewKeyPage({super.key});

  late MobileScanner scanner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              scanner = MobileScanner(
                // fit: BoxFit.contain,
                controller: MobileScannerController(
                  torchEnabled: true,
                ),
                onDetect: (capture) {
                  final barcodes = capture.barcodes;
                  final image = capture.image;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                child: const Text('Scan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

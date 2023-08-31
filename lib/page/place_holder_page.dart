import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceHolderPage extends ConsumerWidget {
  const PlaceHolderPage({
    required this.files,
    required this.text,
    super.key,
  });

  final List<String> files;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

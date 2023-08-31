import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AppName extends ConsumerWidget {
  const AppName({
    this.fontSize = 60,
    this.color = Colors.white,
    super.key,
  });

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      'Wishiz',
      style: GoogleFonts.pacifico(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AppName extends ConsumerWidget {
  const AppName({
    this.fontSize = 60,
    this.color = Colors.white,
    this.text = 'Wishiz', // 'Wishiz
    super.key,
  });

  final double fontSize;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      style: GoogleFonts.pacifico(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}

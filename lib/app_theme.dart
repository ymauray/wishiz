import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const lightViolet = Color(0xFFD8B2F1);
  static const violet = Color(0xFFC792EB);
  static const darkViolet = Color(0xFFB772E5);

  ThemeData themeData(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: AppTheme.violet,
        drawerTheme: const DrawerThemeData(
          shadowColor: Colors.transparent,
          scrimColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkViolet,
          selectedItemColor: Colors.white,
          unselectedItemColor: lightViolet,
          elevation: 2,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppTheme.violet,
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.white,
          prefixIconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorStyle: TextStyle(height: 0.01, color: Colors.transparent),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: AppTheme.violet,
          selectionHandleColor: AppTheme.violet,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: AppTheme.violet,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
            foregroundColor: MaterialStatePropertyAll<Color>(AppTheme.violet),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
        ),
        dialogBackgroundColor: AppTheme.violet,
      );
}

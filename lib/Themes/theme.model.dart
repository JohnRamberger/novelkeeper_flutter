import 'package:flutter/material.dart';

class NovelKeeperTheme {
  MaterialColor primary;
  Color? accent;
  Color? background;
  Color? foreground;
  Color? backgroundSecondary;

  NovelKeeperTheme({
    required this.primary,
    this.accent,
    this.background,
    this.foreground,
    this.backgroundSecondary,
  });

  ThemeData light() {
    return ThemeData(
        primarySwatch: primary,
        accentColor: accent ?? primary.shade400,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white));
  }

  ThemeData dark() {
    return ThemeData(
        primarySwatch: primary,
        accentColor: accent ?? primary.shade400,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        backgroundColor: background,
        shadowColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            backgroundColor: background, shadowColor: Colors.transparent),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor:
                backgroundSecondary ?? background ?? Colors.transparent));
  }
}



// light: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.purple,
//         accentColor: Colors.purple,
//       ),
//       dark: ThemeData(
//           brightness: Brightness.dark,
//           scaffoldBackgroundColor: const Color.fromRGBO(20, 31, 24, 1),
//           backgroundColor: const Color.fromRGBO(20, 31, 24, 1),
//           appBarTheme: const AppBarTheme(
//               backgroundColor: Color.fromRGBO(20, 31, 24, 1),
//               shadowColor: Colors.transparent),
//           bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//               backgroundColor: Color.fromRGBO(20, 31, 24, 1)),
//           primarySwatch: Colors.purple,
//           accentColor: Colors.purple),
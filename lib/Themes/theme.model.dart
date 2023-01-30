import 'package:flutter/material.dart';

class NovelKeeperTheme {
  MaterialColor? primary;
  Color? accent;
  Color? background;

  NovelKeeperTheme({
    required this.primary,
    required this.accent,
    required this.background,
  });

  ThemeData light() {
    return ThemeData(
        primarySwatch: primary!,
        accentColor: accent!,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            backgroundColor: background!, shadowColor: Colors.transparent),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white));
  }

  ThemeData dark() {
    return ThemeData(
        primarySwatch: primary!,
        accentColor: accent!,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background!,
        backgroundColor: background!,
        appBarTheme: AppBarTheme(
            backgroundColor: background!, shadowColor: Colors.transparent),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: background!));
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
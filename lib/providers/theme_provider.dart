import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    //primaryColor: Colors.cyanAccent,
    //accentColor: Colors.cyanAccent,
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.black,
    brightness: Brightness.dark,
    indicatorColor: Colors.white,
    appBarTheme: AppBarTheme(brightness: Brightness.dark),
    scaffoldBackgroundColor: Colors.grey[900],
    //colorScheme: ColorScheme.dark(),

    textTheme: GoogleFonts.patrickHandTextTheme(),
    cardColor: Colors.white70,
    dividerColor: Colors.cyanAccent,
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.cyanAccent,
    accentColor: Colors.cyanAccent,
    primaryColorBrightness: Brightness.light,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
    appBarTheme: AppBarTheme(brightness: Brightness.light),
    canvasColor: Colors.cyan[800],
    scaffoldBackgroundColor: Colors.amber[100],
    //colorScheme: ColorScheme.light(),

    textTheme: GoogleFonts.patrickHandTextTheme(),
    cardColor: Colors.white,
    dividerColor: Colors.black,
  );
}

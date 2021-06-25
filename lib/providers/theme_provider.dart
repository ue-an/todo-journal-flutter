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
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(),
    accentColor: Colors.cyan[600],
    primaryColor: Colors.cyan[800],
    textTheme: GoogleFonts.patrickHandTextTheme(),
    cardColor: Colors.white70,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.amber[100],
    colorScheme: ColorScheme.light(),
    accentColor: Colors.cyan[600],
    primaryColor: Colors.cyan[800],
    textTheme: GoogleFonts.patrickHandTextTheme(),
  );
}

import 'package:flutter/material.dart';
import 'package:journal_todo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        //final provider = context.read<ThemeProvider>();
        provider.toggleTheme(value);
      },
    );
  }
}

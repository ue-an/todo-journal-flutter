import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_todo/providers/journal_provider.dart';
import 'package:journal_todo/providers/tasks_provider.dart';
import 'package:journal_todo/providers/theme_provider.dart';
import 'package:journal_todo/screens/journal_home.dart';
import 'package:journal_todo/screens/tasks_home.dart';
import 'package:journal_todo/utils/change_theme_switch.dart';
import 'package:journal_todo/utils/routes.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    TaskScreen(),
    JournalScreen(),
  ];

  void onBottomTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JEntryProvider()),
        ChangeNotifierProvider(create: (_) => TEntryProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Todo Plus Journal App'),
            actions: [
              ChangeThemeSwitch(),
            ],
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add_check),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Journal',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: onBottomTap,
          ),
        ),
        theme: ThemeData(
          accentColor: Colors.cyan[600],
          primaryColor: Colors.cyan[800],
          textTheme: GoogleFonts.patrickHandTextTheme(),
        ),
        
      ),
    );
  }
}

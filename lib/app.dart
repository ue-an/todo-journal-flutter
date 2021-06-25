import 'package:flutter/material.dart';
import 'package:journal_todo/providers/journal_provider.dart';
import 'package:journal_todo/providers/tasks_provider.dart';
import 'package:journal_todo/providers/theme_provider.dart';
import 'package:journal_todo/screens/journal_home.dart';
import 'package:journal_todo/screens/tasks_home.dart';
import 'package:journal_todo/utils/change_theme_switch.dart';
import 'package:journal_todo/utils/drawer.dart';
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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => JEntryProvider()),
          ChangeNotifierProvider(create: (_) => TEntryProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
            home: Scaffold(
              appBar: AppBar(
                title: Text('Todo Plus Journal App'),
                actions: [
                  ChangeThemeSwitch(),
                ],
              ),
              drawer: SafeArea(
                child: CustomDrawer(),
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
                selectedItemColor: Colors.cyan[800],
                onTap: onBottomTap,
              ),
            ),
            // theme: ThemeData(
            //   accentColor: Colors.cyan[600],
            //   primaryColor: Colors.cyan[800],
            //   textTheme: GoogleFonts.patrickHandTextTheme(),
            // ),
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: themeProvider.themeMode,
          );
        },
      );
}

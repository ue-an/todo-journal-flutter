import 'package:flutter/material.dart';
import 'package:journal_todo/screens/journal_entry.dart';

class Routes {
  Routes._();

  static const String jentry = '/jentry';

  static final routes = <String, WidgetBuilder>{
    jentry: (BuildContext context) => JEntryScreen()
  };
}

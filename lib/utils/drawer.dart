import 'package:flutter/material.dart';
import 'package:journal_todo/utils/change_theme_switch.dart';
import 'package:journal_todo/utils/routes.dart';

class CustomDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 9, vertical: 30);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // padding: EdgeInsets.all(30.0),
        //color: Colors.cyan[600],
        child: ListView(
          padding: padding,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.brightness_2),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
                ChangeThemeSwitch(),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            //============
            buildMenuItem(
              text: 'About',
              icon: Icons.error_outline,
            ),
            SizedBox(height: 20.0),
            Divider(
              thickness: 1.0,
            ),
            SizedBox(height: 20.0),
            buildMenuItem(
              text: 'Updates',
              icon: Icons.update,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
  }) {
    final color = Colors.grey[600];
    final hoverColor = Colors.cyan;

    return ListTile(
      leading: Icon(
        icon,
      ), //color: color),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: color,
        ),
        // style: TextStyle(
        //   color: color,
        // ),
      ),
      hoverColor: hoverColor,
    );
  }
}

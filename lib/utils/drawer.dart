import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 9, vertical: 30);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // padding: EdgeInsets.all(30.0),
        color: Colors.cyan[800],
        child: ListView(
          padding: padding,
          children: <Widget>[
            SizedBox(height: 20.0),
            buildMenuItem(
              text: 'Dark Mode',
              icon: Icons.brightness_2,
            ),
            SizedBox(height: 20.0),
            buildMenuItem(
              text: 'About',
              icon: Icons.people,
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.white),
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
    final color = Colors.white;
    final hoverColor = Colors.cyan;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
    );
  }
}

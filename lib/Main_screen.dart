import 'package:flutter/material.dart';
class MainsScreen extends StatefulWidget {
  static const String id = 'Main_Screen';
  @override
  _MainsScreenState createState() => _MainsScreenState();
}

class _MainsScreenState extends State<MainsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Dar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            
          ],

      ),
    );
  }
}


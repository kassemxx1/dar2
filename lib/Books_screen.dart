import 'package:flutter/material.dart';
import 'Main_screen.dart';
import 'Main_screen.dart';
class BooksScreen extends StatefulWidget {
  static const String id = 'Books_Screen';
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(MainsScreen.book);
  }
  @override
  Widget build(BuildContext context) {
    return products();
  }
}

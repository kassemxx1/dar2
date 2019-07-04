import 'package:flutter/material.dart';
import 'package:dar/Welcome_Screen.dart';
import 'Main_screen.dart';
import 'Books_screen.dart';

void main() => runApp(Dar());

class Dar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          MainsScreen.id : (context) => MainsScreen(),
          BooksScreen.id :(context) => BooksScreen(),
//          RegistrationScreen.id : (context) => RegistrationScreen(),
        }
    );
  }
}



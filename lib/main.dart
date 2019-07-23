import 'package:flutter/material.dart';
import 'package:dar/Welcome_Screen.dart';
import 'Main_screen.dart';
import 'Books_screen.dart';
import 'package:dar/Swiper_Screen.dart';
import 'basket_Screen.dart';
import 'Search_Screen.dart';
import 'registration_screen.dart';
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
          carddd.id : (context) => carddd(),
          BasketScreen.id : (context) => BasketScreen(),
          SearchScreen.id: (context) => SearchScreen(),
          RegistrationScreen.id: (context) =>RegistrationScreen(),

        }
    );
  }
}



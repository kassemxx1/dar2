import 'package:flutter/material.dart';
import 'package:dar/Rounded_Button.dart';
import 'package:dar/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final _firestore = Firestore.instance;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  static final nnn = [];

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('images/b.png'),
                    height: 60.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  TypewriterAnimatedTextKit(
                      text: ['دار النشر'],
                      textStyle: TextStyle(
                        fontSize: 45.0,
                      ),
                      textAlign: TextAlign.right),
                ],
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: KTextFieldImputDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: KTextFieldImputDecoration.copyWith(
                      hintText: 'Enter Your Password')),
              RoundedButton(
                colour: Colors.blueAccent,
                title: 'LogIn',
                onPressed: () async {
//                  try {
//                    final user = await _auth.signInWithEmailAndPassword(
//                        email: email, password: password);
//                    if (user != null) {
//                      Navigator.pushNamed(context, MainsScreen.id);
//                    }
//                  } catch (e) {
//                    print(e);
//                  }
                  Navigator.pushNamed(context, MainsScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getdata() async {
    final messages = await _firestore.collection('categories').getDocuments();
    for (var message in messages.documents) {
      final categorie = message.data['cat'].toString();
      final ImageLink = message.data['imagelink'].toString();

      WelcomeScreen.nnn.add({'cat': categorie, 'imagelink': ImageLink});
      print(WelcomeScreen.nnn);
    }
  }
}

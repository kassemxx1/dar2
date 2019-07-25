import 'package:flutter/material.dart';
import 'package:dar/Rounded_Button.dart';
import 'package:dar/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'registration_screen.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:toast/toast.dart';

final _firestore = Firestore.instance;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  static final nnn = [];
  static var allbook = [];
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  void getallBookk() async {
    WelcomeScreen.allbook.clear();
    SearchBook.clear();
    final messages = await _firestore.collection('books').getDocuments();
    for (var message in messages.documents) {
      final title = message.data['title'].toString();
      final imagename = message.data['imagename'].toString();
      final price = message.data['price'].toString();
      final detail = message.data['detail'].toString();
      final writer = message.data['writer'].toString();

      WelcomeScreen.allbook.add({
        'title': title,
        'imagelink': imagename,
        'price': price,
        'detail': detail,
        'writer': writer,
      });
      SearchBook.add(title);
    }
  }

  @override
  void initState() {
    getallBookk();
    // TODO: implement initState
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
              Flexible(
                child: Row(
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
                  XsProgressHud.show(context);
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    XsProgressHud.hide();
                    if (user != null) {
                      Navigator.pushNamed(context, MainsScreen.id);
                    }
                  } catch (e) {
                    print(e);
                    XsProgressHud.hide();
                    Toast.show('${e.toString()}', context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  }
//                                   Navigator.pushNamed(context, MainsScreen.id);
                },
              ),
              Flexible(
                child: MaterialButton(
                  child: Text(
                    'Create an account',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getdata() async {
    WelcomeScreen.nnn.clear();
    final messages = await _firestore.collection('categories').getDocuments();
    for (var message in messages.documents) {
      final categorie = message.data['cat'].toString();
      final ImageLink = message.data['imagelink'].toString();
      WelcomeScreen.nnn.add({'cat': categorie, 'imagelink': ImageLink});
    }
  }
}

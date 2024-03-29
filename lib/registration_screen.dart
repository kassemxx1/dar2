import 'package:flutter/material.dart';
import 'Rounded_Button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Main_screen.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:toast/toast.dart';
class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  child: Image.asset('images/cat_img.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: KTextFieldImputDecoration.copyWith(hintText: 'Enter your email'),
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
              decoration:KTextFieldImputDecoration.copyWith(hintText: 'Enter Your Password')
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(colour: Colors.blueAccent,title: 'Register',
              onPressed: () async{
                XsProgressHud.show(context);

              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newUser != null){
                  XsProgressHud.hide();
                  Navigator.pushNamed(context,MainsScreen.id);
                }
              }
              catch(e){
                XsProgressHud.hide();
                Toast.show('$e', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              }

            },)
          ],
        ),
      ),
    );
  }
}

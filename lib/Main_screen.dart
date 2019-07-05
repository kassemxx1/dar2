import 'package:flutter/material.dart';
import 'package:dar/Welcome_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Books_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

final _firestore = Firestore.instance;
String SCategori;

class MainsScreen extends StatefulWidget {
  static const String id = 'Main_Screen';
  static final book = [];
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
      body: products(),
    );
  }
}

class CardCat extends StatelessWidget {
  CardCat(
    this.cat,
    this.imagelink,
  );
  final String cat;
  final String imagelink;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: () async{
        MainsScreen.book.clear();
        final messages = await _firestore
            .collection('books')
            .where('cat', isEqualTo: cat)
            .getDocuments();
        for (var message in messages.documents) {
          final title = message.data['title'].toString();
          final imagename = message.data['imagename'].toString();

          MainsScreen.book.add({'cat': title, 'imagelink': imagename});

        }

        Navigator.pushNamed(context, BooksScreen.id);
      },

      child: Column(
          children: <Widget>[
            new CachedNetworkImage(
              imageUrl: imagelink,
//              placeholder: new CircularProgressIndicator(),
//              errorWidget: new Icon(Icons.error),
            ),
            Text(cat),
          ],
      ),
    );
  }
}

class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(WelcomeScreen.nnn.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: WelcomeScreen.nnn.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return CardCat(WelcomeScreen.nnn[index]['cat'],
              WelcomeScreen.nnn[index]['imagelink']);
        },
      ),
    );
  }
}

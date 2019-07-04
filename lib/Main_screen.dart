import 'package:flutter/material.dart';
import 'package:dar/Welcome_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Books_screen.dart';

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
    void getdata(String selectedCategorie) async {
      final messages = await _firestore
          .collection('books')
          .where('cat', isEqualTo: selectedCategorie)
          .getDocuments();
      for (var message in messages.documents) {
        final title = message.data['title'].toString();
        final imagename = message.data['imagename'].toString();

        MainsScreen.book.add({'cat': title, 'imagelink': imagename});
        print(MainsScreen.book);
      }
    }
    return Card(
      child: MaterialButton(
        onPressed: (){
          getdata(cat);
          Navigator.pushNamed(context, BooksScreen.id);
        },
        child: InkWell(
          onTap: () {

          },
          child: GridTile(
            child: Image.network(imagelink),
            footer: Container(
              child: ListTile(
                leading: Center(
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(WelcomeScreen.nnn.length);
    return GridView.builder(
      itemCount: WelcomeScreen.nnn.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return CardCat(WelcomeScreen.nnn[index]['cat'],
            WelcomeScreen.nnn[index]['imagelink']);
      },
    );
  }
}

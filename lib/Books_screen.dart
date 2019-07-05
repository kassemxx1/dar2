import 'package:flutter/material.dart';
import 'Main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return Column(
      children: <Widget>[
        BooksWidgets(),
      ],
    );
  }
}
class BooksWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MainsScreen.book.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: MainsScreen.book.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return CardBooks(MainsScreen.book[index]['cat'],
              MainsScreen.book[index]['imagelink']);
        },
      ),
    );
  }
}
class CardBooks extends StatelessWidget {
  CardBooks(
      this.cat,
      this.imagelink,
      );
  final String cat;
  final String imagelink;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: () async{

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
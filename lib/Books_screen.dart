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
      body: BooksWidgets(),
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
          return CardBooks(
              MainsScreen.book[index]['cat'],
              MainsScreen.book[index]['imagelink'],
              MainsScreen.book[index]['price']);
        },
      ),
    );
  }
}
class CardBooks extends StatelessWidget {
  CardBooks(this.cat,
      this.imagelink,
      this.price,);

  final String cat;
  final String imagelink;
  final String price;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {},
      child: Column(
        children: <Widget>[
          new CachedNetworkImage(
            imageUrl: imagelink,
//              placeholder: new CircularProgressIndicator(),
//              errorWidget: new Icon(Icons.error),
          ),
          Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('$cat  '),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: Text(
                    '$price\$',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

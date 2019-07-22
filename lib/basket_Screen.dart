import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Main_screen.dart';

final _firestore = Firestore.instance;
var theCart = [];

class BasketScreen extends StatefulWidget {
  static const String id = 'Basket_Screen';
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: MsgStream(),
    );
  }
}

class MsgStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('cart')
          .where('email', isEqualTo: MainsScreen.me)
          .snapshots(),
      builder: (context, snapshot) {
        theCart.clear();
        for (var msg in snapshot.data.documents) {
          final title = msg['title'].toString();
          final imagename = msg.data['imagelink'].toString();
          final price = msg.data['price'].toString();
          final writer = msg.data['writer'].toString();
          theCart.add({
            'title': title,
            'imagelink': imagename,
            'price': price,
            'writer': writer,
          });
        }
        return ListView.builder(
            itemCount: theCart.length + 1,
            itemBuilder: (context, index) {
              if (index < theCart.length) {
                return Container(
                    child: ListTile(
                  leading:
                      CachedNetworkImage(imageUrl: theCart[index]['imagelink']),
                  title: Text(theCart[index]['title']),
                ));
              } else {
                return MaterialButton(
                  onPressed: () async {
                    theCart.clear();
                    final messages = await _firestore
                        .collection('cart')
                        .where('email', isEqualTo: MainsScreen.me)
                        .getDocuments();
                    for (var i in messages.documents) {
                      final id = i.documentID;
                      _firestore.collection('cart').document(id).delete();
                    }
                  },
                  child: Text('BUY'),
                );
              }
            });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'Main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:dar/Swiper_Screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dar/Rounded_Button.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
String imagelinkk;
final _firestore = Firestore.instance;
int indexx;
String Pricee;

ScrollController controller;
Route route = MaterialPageRoute(builder: (context) => BooksScreen());

class BooksScreen extends StatefulWidget {
  static const String id = 'Books_Screen';
  FirebaseUser loggedInUser;
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
      body: ExpandableCardPage(
        page: Center(
          child: BooksWidgets(),
        ),
        expandableCard: ExpandableCard(
          children: <Widget>[Text("Hello world")],
          minHeight: 150.0,
          maxHeight: 300.0,
          hasRoundedCorners: true,
        ),
      ),
    );
  }
}

//GGGGGRRRRRRRRRRRIIIIIIIIIIIIIDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
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
          return MaterialButton(
              child: CardBooks(
                MainsScreen.book[index]['title'],
                MainsScreen.book[index]['imagelink'],
                MainsScreen.book[index]['price'],
              ),
              onPressed: () {
                Navigator.of(context).push(TransparentRoute(
                    builder: (BuildContext context) => ddd(index)));
              });
        },
      ),
    );
  }
}

//WIIIIDDDDDDGGGGEEETTTTT  GGGRRRIIIDDDDDD
class CardBooks extends StatelessWidget {
  CardBooks(
    this.cat,
    this.imagelink,
    this.price,
  );

  final String cat;
  final String imagelink;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

//SSSSSSSSSSWWWWWWWWWWIIIIIIIIIIIIIIIIIPPPPPPPPPPPEEEEEEEEEEEEERRRRRRRRRRRRRRRRRRRRR
class ddd extends StatelessWidget {
  ddd(this.kkk);
  final int kkk;
  Function dismissImg;
  Function addImg;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Swiper(
        itemCount: MainsScreen.book.length,
        itemBuilder: (BuildContext context, lll) {
          var ccc = kkk + lll;
          if (ccc > MainsScreen.book.length - 1) {
            var aaa = ccc - MainsScreen.book.length;
            ccc = aaa;
          }
          return CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 300,
                floating: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  background: CachedNetworkImage(
                      imageUrl: MainsScreen.book[ccc]['imagelink'],
                  fit: BoxFit.fill,
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(MainsScreen.book[ccc]['title']),
                      SizedBox(width: 40.0,),
                      Text('${MainsScreen.book[ccc]['price']} \$'),
                    ],
                  ),
                ),
              ),
              SliverFixedExtentList(
                  delegate: SliverChildListDelegate([
                Center(
                  child: Material(
                    child: Text(MainsScreen.book[ccc]['title'],style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,


                    ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),

              ],

                  ),
                 itemExtent: 50.0,
              ),
              SliverFixedExtentList(
                delegate: SliverChildListDelegate([
                  Material(
                    child: Text(MainsScreen.book[ccc]['detail'],style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,

                    ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                ],

                ),
                itemExtent: 200,
              ),
              SliverFixedExtentList(
                delegate: SliverChildListDelegate([
                  Material(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: RoundedButton(onPressed:(){
                        var email =FirebaseUser;
                        var bookTitle=MainsScreen.book[ccc]['title'];
                        _firestore.collection('cart').add({
                          'email':email,
                          'book':bookTitle,
                        });


                      },
                        title: 'Add to Cart',
                        colour: Colors.lightBlueAccent,

                      ),
                    ),
                  ),

                ],

                ),
                itemExtent: 70.0,
              ),




            ],
          );
        },
        viewportFraction: 1,
        scale: 1,
        loop: true,
      ),
    );
  }
}

//Transparent==================================================
class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}

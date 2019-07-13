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
import 'package:flutter/gestures.dart';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';
String imagelinkk;
AnimationController controller;
int indexx;
String Pricee;
DragStartBehavior dragStartBehavior;

Route route = MaterialPageRoute(builder: (context) => BooksScreen());
double scalee=1;
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
          child: Column(
            children: <Widget>[
              Center(child: Text('$cat  ')),
              SizedBox(
                height: 10.0,
              ),

              Center(
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

  DragStartBehavior dragStartBehavior=DragStartBehavior.start;
  final int kkk;

  @override
  Widget build(BuildContext context) {
    void add(int l){
      final _firestore = Firestore.instance;
      _firestore.collection('cart').add({
        'email': 'sdasdasd',
        'title': MainsScreen.book[l]['title'],
      });
      controller.isDismissed;
    }
    return Container(
      color: Colors.white,
      child: Swiper(
        itemCount: MainsScreen.book.length,
        itemBuilder: (BuildContext context, lll) {
          if(DragStartBehavior.start==true){
            scalee=1;
          }
          var ccc = kkk + lll;
          if (ccc > MainsScreen.book.length - 1) {
            var aaa = ccc - MainsScreen.book.length;
            ccc = aaa;

          }
          return CustomScrollView(
          dragStartBehavior:dragStartBehavior ,

            slivers: <Widget>[

              SliverAppBar(

                expandedHeight: 300,
                floating: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(

                  background: Stack(

                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                  imageUrl: MainsScreen.book[ccc]['imagelink'],

                  ),
                      ),
                    ],
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(MainsScreen.book[ccc]['title'],style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0
                      ),
                        textDirection: TextDirection.rtl,),

                    ],
                  ),
                ),
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
                  Container(
                    width: 200,
                    height: 60,
                    child: ProgressButton(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Text(
                        "Add to Car",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: (controller){
                        controller.forward();
                        add(ccc);

                      },


                    ),
                  ),

                ],

                ),
                itemExtent: 60,
              ),

            ],
          );
        },
        viewportFraction: scalee,
        scale: scalee,
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
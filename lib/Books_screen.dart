import 'package:flutter/material.dart';
import 'Main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:dar/Swiper_Screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

String imagelinkk;
int indexx;
String Pricee;

ScrollController controller;
Route route = MaterialPageRoute(builder: (context) => BooksScreen());

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
                MainsScreen.book[index]['cat'],
                MainsScreen.book[index]['imagelink'],
                MainsScreen.book[index]['price'],
                ),
            onPressed: (){

              Navigator.of(context)
              .push(TransparentRoute(builder: (BuildContext context) => ddd(index)));}
          );

        },

      ),
    );
  }
}

//WIIIIDDDDDDGGGGEEETTTTT  GGGRRRIIIDDDDDD
class CardBooks extends StatelessWidget {
  CardBooks(this.cat, this.imagelink, this.price,);

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
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: MainsScreen.book.length,
      itemBuilder: (BuildContext context,  lll) {
       var ccc = kkk + lll;
       if(ccc > MainsScreen.book.length-1){
        var aaa = ccc - MainsScreen.book.length;
          ccc = aaa;
       }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        child: SizedBox(
                          height: 50.0,
                        ),
                      ),
                      new CachedNetworkImage(
                        imageUrl: MainsScreen.book[ccc]['imagelink'],
//              placeholder: new CircularProgressIndicator(),
//              errorWidget: new Icon(Icons.error),
                        fit: BoxFit.fill,

                      ),
//                      new Image.network(
//                        imagelinkk,
//                        fit: BoxFit.fill,
//                        gaplessPlayback: false,
//                      ),
//                      new Image.network(
//                        imagelinkk,
//                        fit: BoxFit.fill,
//                        gaplessPlayback: false,
//                      ),
//                      new Image.network(
//                        imagelinkk,
//                        fit: BoxFit.fill,
//                        gaplessPlayback: false,
//                      ),
//                      new Image.network(
//                        imagelinkk,
//                        fit: BoxFit.fill,
//                        gaplessPlayback: false,
//                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      viewportFraction: 0.8,
      scale: 0.8,
      loop: true,
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

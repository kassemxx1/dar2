import 'package:flutter/material.dart';
import 'Main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:dar/Swiper_Screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

      body:  ExpandableCardPage(
        page: Center(
          child: BooksWidgets(),
        ),
        expandableCard: ExpandableCard(
          children: <Widget>[Text("Hello world")],
          minHeight: 150.0,
          maxHeight: 300.0,
          hasRoundedCorners:true ,

        ),
      ),
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
      onPressed: ()  {
        print('kassem');

     //  Navigator.pushNamed(context, carddd.id);
        Navigator.of(context).push(
            TransparentRoute(builder: (BuildContext context) => ddd())
        );
      },

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

class ddd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(itemCount: 1,
      itemBuilder: (BuildContext context ,int ){
        return Container(
          child: new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
            gaplessPlayback: false,
          ),
        );
      },
      viewportFraction: 0.8,
      scale: 0.8,


    );
  }
}
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
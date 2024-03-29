import 'package:flutter/material.dart';
import 'package:dar/Welcome_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Books_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:material_search/material_search.dart';
import 'AnimatedButton.dart';
import 'basket_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:dar/Rounded_Button.dart';
var items = List<String>();
var all = [{}];
var one = [{}];
final _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
String SCategori;

List<String> SearchBook = [];
var i = 0;
String _selected;

class MainsScreen extends StatefulWidget {
  static const String id = 'Main_Screen';
  static final book = [];
  static var me="";
  @override
  _MainsScreenState createState() => _MainsScreenState();
}

class _MainsScreenState extends State<MainsScreen> {
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        MainsScreen.me = loggedInUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  //RETRIEVE ALL BOOK FROM FIREBASE


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    i = 0;
   // getallBook();
    getCurrentUser();
  }

//SCAFOLD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.pushNamed(context, BasketScreen.id);
//        },
//        child: Text('basket'),
//      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
                // flutter defined function
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      elevation: 10,
                      title: new Text("Sign Out"),
                      content: new Text("are you Sure!"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                            onPressed: () async{
                              XsProgressHud.show(context);
                              try {
                                 await _auth.signOut();
                                  XsProgressHud.hide();
                                  Navigator.pushNamed(
                                      context, WelcomeScreen.id);

                              }
                              catch(e){
                                XsProgressHud.hide();
                                Toast.show('$e', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                              }

                            },
                            child: new Text("Ok"),
                        ),

                      ],
                    );
                  },
                );


            },
          ),
        ],
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
      drawer: Container(
        width: MediaQuery.of(context).size.width/1.6,
        height: MediaQuery.of(context).size.height-30,
        child: Drawer(
          elevation: 20,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/cat_img.png',fit: BoxFit.fill,),
                  ),

              ),

              Column(
                children: <Widget>[
                  Text('Your Email:',style: TextStyle(fontSize: 20),),
                  Text('${MainsScreen.me}',style: TextStyle(fontSize: 20),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RoundedButton(
                  title: 'SignOut',
                  colour: Colors.blueAccent,
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          elevation: 10,
                          title: new Text("Sign Out"),
                          content: new Text("are you Sure!"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              onPressed: () async{
                                XsProgressHud.show(context);
                                try {
                                  await _auth.signOut();
                                  XsProgressHud.hide();
                                  Navigator.pushNamed(
                                      context, WelcomeScreen.id);

                                }
                                catch(e){
                                  XsProgressHud.hide();
                                  Toast.show('$e', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                                }

                              },
                              child: new Text("Ok"),
                            ),

                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RoundedButton(
                  title: 'About',
                  colour: Colors.blueAccent,
                  onPressed: (){

                },
                ),
              ),

            ],
          ),
        ),
      ),
      body: products(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        height: 50.0,
        color: Colors.white,
        items: <Widget>[
          Column(
            children: <Widget>[Icon(Icons.book, size: 30), Text('Main')],
          ),
          Column(
            children: <Widget>[Icon(Icons.search, size: 30), Text('Search')],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.shopping_cart, size: 30),
              Text('Cart')
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            i = index;
          });

          //Handle button tap
        },
      ),
    );
  }
}

//CARDCAT WITH RETRIEVE CATEGORIES
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
      onPressed: () async {
        XsProgressHud.show(context);
        try{
          MainsScreen.book.clear();
          final messages = await _firestore
              .collection('books')
              .where('cat', isEqualTo: cat)
              .getDocuments();
          for (var message in messages.documents) {
            final title = message.data['title'].toString();
            final imagename = message.data['imagename'].toString();
            final price = message.data['price'].toString();
            final detail = message.data['detail'].toString();

            MainsScreen.book.add({
              'title': title,
              'imagelink': imagename,
              'price': price,
              'detail': detail
            });
          }
          XsProgressHud.hide();
          Navigator.pushNamed(context, BooksScreen.id);
        }
        catch(e){
          XsProgressHud.hide();
          Toast.show('${e.toString()}', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }


      },
      child: Column(
        children: <Widget>[
          new CachedNetworkImage(
            imageUrl: imagelink,
//              placeholder: new CircularProgressIndicator(),
//              errorWidget: new Icon(Icons.error),
          ),
          Text(cat,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}

//PRODUCTS
class products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (i == 0) {
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
    if (i == 1) {
      return MaterialSearchInput<String>(
        placeholder: 'Search',
        onSelect: (String selected) {
          if (selected == null) {
            //user closed the MaterialSearch without selecting any value

          }

          _selected = selected;
          for (int i = 0; i < WelcomeScreen.allbook.length; i++) {
            var j = WelcomeScreen.allbook[i]['title'];
            if (j == _selected) {
              Navigator.of(context).push(TransparentRoute(
                  builder: (BuildContext context) => searchable(i)));
            }
          }
        },
        results: SearchBook.map((name) => new MaterialSearchResult<String>(
              value: name, //The value must be of type <String>
              text: name, //String that will be show in the list

              icon: Icons.book,
            )).toList(),
      );

    }
    if (i == 2) {
      return BasketScreen();
    }
  }
}

//SEARCHABLE
class searchable extends StatelessWidget {
  int ind;
  searchable(this.ind);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: WelcomeScreen.allbook[ind]['imagelink'],
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              title: Text(
                WelcomeScreen.allbook[ind]['title'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
                textDirection: TextDirection.rtl,
              ),
              titlePadding: EdgeInsets.only(bottom: 5),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                Material(
                  child: Text(
                    '  US \$ ${WelcomeScreen.allbook[ind]['price']}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            itemExtent: 50,
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                Material(
                  child: Text(
                    WelcomeScreen.allbook[ind]['writer'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
            itemExtent: 50,
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                Material(
                  child: Text(
                    WelcomeScreen.allbook[ind]['detail'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
            itemExtent: 600,
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: AnimatedButton(
                        initialText: 'Add To Cart',
                        finalText: 'Added',
                        buttonStyle: ButtonStyle(
                            primaryColor: Colors.blue,
                            secondaryColor: Colors.grey,
                            elevation: 20.0,
                            initialTextStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            finalTextStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            borderRadius: 10.0),
                        iconData: Icons.shopping_cart,
                        animationDuration: const Duration(milliseconds: 500),
                        onTap: () {
                          print('kassem');
                          final _firestore = Firestore.instance;
                          _firestore.collection('cart').add({
                            'email': MainsScreen.me,
                            'title': WelcomeScreen.allbook[ind]['title'],
                            'price': WelcomeScreen.allbook[ind]['price'],
                            'imagelink': WelcomeScreen.allbook[ind]['imagelink'],
                            'writer': WelcomeScreen.allbook[ind]['writer'],
                          });
                        },
                        iconSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            itemExtent: 60,
          ),
          SliverFixedExtentList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 60.0,
                  color: Colors.white,
                )
              ]),
              itemExtent: 60.0)
        ],
      ),
    );
  }
}

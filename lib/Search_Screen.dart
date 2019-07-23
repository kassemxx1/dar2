import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Books_screen.dart';
import 'Main_screen.dart';
final _firestore = Firestore.instance;
var items = List<String>();
var all=[{}];
var one=[{}];

class SearchScreen extends StatefulWidget {
  static const String id = 'Search_Screen';
  static  String catt;
  static var duplicateItems = List<String>();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var itemm = List<String>();

  String title;

  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(SearchScreen.duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(SearchScreen.duplicateItems);
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child:  getsub(),
          ),
        ],
      ),
    );
  }
}
class getsub extends StatefulWidget {

  @override
  _getsubState createState() => _getsubState();
}
class _getsubState extends State<getsub> {
  void filterr(String name){
    for (int i=0;i<all.length;i++){
      if ( name == all[i]['title']){
        one.add(all[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:_firestore.collection('books').snapshots(),
      builder: (context,snapshot){
        SearchScreen.duplicateItems.clear();
        for(var msg in snapshot.data.documents){
          final name =msg['title'].toString();
          final cat =msg['cat'].toString();
          final price=msg['price'].toString();
          final image = msg['imagename'].toString();
          SearchScreen.duplicateItems.add(name);
          all.add({
            'title':name,
            'price':price,
            'image':image,
          });
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            filterr(items[index]);
            return ListTile(
              title: Text('${SearchScreen.duplicateItems[index]}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(TransparentRoute(
                  builder: (BuildContext context) => searchable(index)));
              },

//              leading: CachedNetworkImage(imageUrl: '${one[index]['image']}'),
            );
          },
        );
      },
    );
  }
}
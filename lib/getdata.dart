import 'package:cloud_firestore/cloud_firestore.dart';
void getdata(String field,List addtolist) async{
  final _firestore = Firestore.instance;
    addtolist.clear();
    final messages = await _firestore
        .collection('books')
        .where('cat', isEqualTo: field)
        .getDocuments();
    for (var message in messages.documents) {
      final title = message.data['title'].toString();
      final imagename = message.data['imagename'].toString();
      final price = message.data['price'].toString();
      final detail = message.data['detail'].toString();

      addtolist.add({
        'title': title,
        'imagelink': imagename,
        'price': price,
        'detail': detail
      });
    }

}
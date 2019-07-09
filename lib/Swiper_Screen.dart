import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class carddd extends StatefulWidget {
  static const String id = 'swiper_screen';
  @override
  _cardddState createState() => _cardddState();
}

class _cardddState extends State<carddd> {
  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.5,
      child: Swiper(itemCount: 1,
            itemBuilder: (BuildContext context ,int ){
              return new Image.network(
                "http://via.placeholder.com/288x188",
                fit: BoxFit.fill,
                gaplessPlayback: false,
              );
            },
          viewportFraction: 0.8,
          scale: 0.8,


        ),
    );

  }
}

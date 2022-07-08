import 'package:flutter/material.dart';

String id2 = "";
String title2 = "";
String description2 = "";
String imageURL2 = "";
String sellerEmail2 = "";
DateTime date2 = DateTime.now();
String bidderEmail2="";
int bidPrice2=0;

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    var children2 = [
        Text(id2),
        Text(title2),
        Text(description2),
        Text(imageURL2),
        Text(sellerEmail2),
        Text(date2.toString()),
        Text(bidderEmail2),
        // Text('$bidprice2'),
      ];
    return Scaffold(
      appBar: AppBar(title: const Text('lol')),
      body: Column(children: children2),
    );
  }
}

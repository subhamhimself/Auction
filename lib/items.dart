import 'package:auction/itempage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'itempage.dart';

class ListItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final String sellerEmail;
  // final DateTime date;
  final String bidderEmail;
  final int bidPrice;

  const ListItemWidget(
      {Key? key,
      required this.id,
      required this.title,
      required this.sellerEmail,
      required this.description,
      required this.imageURL,
      // required this.date,
      required this.bidPrice,
      required this.bidderEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        id2 = id;
        title2 = title;
        sellerEmail2 = sellerEmail;
        description2 = description;
        imageURL2 = imageURL;
        bidPrice2 = bidPrice;
        bidderEmail2 = bidderEmail;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ItemPage()));
        //  Navigator.of(context).push(ItemPage());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        decoration: const BoxDecoration(
          color: Colors.grey,
          //  borderRadius: BorderRadius.circular(21)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 194),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 105, maxWidth: 135),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(21),
                    bottomRight: Radius.circular(21)),
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageURL), fit: BoxFit.cover)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> getPresent() async {
  var x = await FirebaseFirestore.instance
      .collection('items')
      // .where('sold', isEqualTo: false)
      .get();
  List<dynamic> t = [];
  for (var element in x.docs) {
    Map<String, dynamic> temp;
    temp = element.data();
    t.add(temp);
  }
  // print(t.runtimeType);
  return t;
}

Future<List<dynamic>> getPast() async {
  var x = await FirebaseFirestore.instance
      .collection('items')
      .where('sold', isEqualTo: true)
      .get();
  var t = [];
  for (var element in x.docs) {
    Map<String, dynamic> temp;
    temp = element.data();
    t.add(temp);
  }
  // print(t);
  // var ans = makeWidgets(t);
  return t;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String id2 = "id";
String title2 = "title";
String description2 = "about the item";
// String imageURL2 = "";
// String imageURL2 = "https://firebasestorage.googleapis.com/v0/b/auction-e9bad.appspot.com/o/nullehdh.jpg?alt=media&token=33e16c6e-326e-4537-88c9-7b3fd4cac625";

String imageURL2 = "http://www.picsum.photos/200/300";
String sellerEmail2 = "huehuehue@hue.hue";
DateTime date2 = DateTime.now();
String bidderEmail2 = "hehe??@bidder.com";
int bidPrice2 = 100;

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auction Page')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 1000,
              height: 30,
            ),
            // Text(id2),
            Image.network(
              imageURL2,
              width: 200,
              height: 400,
            ),

            Text(
              title2,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text(
              description2,
              style: const TextStyle(fontSize: 18),
            ),
            Text('Seller : $sellerEmail2'),
            const SizedBox(
              width: 1000,
              height: 30,
            ),

            Text(
              'Ends : ${date2.day}-${date2.month}-${date2.year}  ${date2.hour}:${date2.minute} hours',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              width: 1000,
              height: 30,
            ),

            Text(
              'Current bid : $bidPrice2 Rupees',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text('By : $bidderEmail2'),
            const SizedBox(
              width: 1000,
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        bidPrice2 += 100;
                        bidderEmail2 =
                            FirebaseAuth.instance.currentUser!.email!;
                      });
                    },
                    child: const Text("+100")),
                ElevatedButton(
                    onPressed: () {
                      print(FirebaseAuth.instance.currentUser?.email);

                      setState(() {
                        bidPrice2 += 100;
                        bidderEmail2 =
                            FirebaseAuth.instance.currentUser!.email!;
                      });
                    },
                    child: const Text("+200")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        bidPrice2 += 100;
                        bidderEmail2 =
                            FirebaseAuth.instance.currentUser!.email!;
                      });
                    },
                    child: const Text("+500")),
              ],
            ),
            const SizedBox(
              width: 1000,
              height: 30,
            ),
          ]),
    );
  }
}

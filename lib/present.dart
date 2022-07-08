// ignore_for_file: curly_braces_in_flow_control_structures, unused_import, prefer_typing_uninitialized_variables

import 'package:auction/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nav.dart';
import 'items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


int index = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Demo'),
      ),
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/additem');
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder(
        stream:
            Stream.periodic(const Duration(seconds: 0)).asyncMap((event) async {
          QuerySnapshot toRtnSnapshot;
          if(index==0)
           toRtnSnapshot = await FirebaseFirestore.instance
              .collection('items')
              .where('close', isGreaterThan: DateTime.now())
              .get();
              else toRtnSnapshot = await FirebaseFirestore.instance
              .collection('items')
              .where('close', isLessThan: DateTime.now())
              .get();
          return toRtnSnapshot;
        }),
        builder: (context, AsyncSnapshot snapshot) {
          List<Widget> currentAuctionItems = []; // for storing listview items
          if (snapshot.hasData) {
            snapshot.data!.docs.forEach((value) => {
                  currentAuctionItems.add(ListItemWidget(
                      id: value.id,
                      title: value["title"],
                      bidPrice: value["bidprice"],
                      sellerEmail: value["seller"],
                      description: value["description"],
                      imageURL: value["imageURL"],
                      bidderEmail: value["bidder"]))
                });
            return currentAuctionItems.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    children: currentAuctionItems,
                  )
                : const Center(
                    child: Text("No Items"),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => index = newIndex),
        currentIndex: index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            // label: snapshot.
            label: 'Running',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Sold',
          ),
        ],
      ),
    );
  }
}

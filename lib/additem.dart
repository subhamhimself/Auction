import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void addItem(String name, String description, int bidprice) async {
  final docItem = FirebaseFirestore.instance.collection('items').doc();
  final json = {
    'title': name,
    'description': description,
    'bidprice': bidprice,
    'seller': FirebaseAuth.instance.currentUser!.email,
    'bidder': 'None',
    'imageURL': 'https://picsum.photos/200/300',
    'close': ddd,
  };
  await docItem.set(json);
}

dynamic ddd = 0;

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ddd = 0;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add item for auction"),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextFormField(
                controller: _desc,
                decoration: const InputDecoration(
                  labelText: 'Description',
                )),
            TextFormField(
                controller: _price,
                decoration: const InputDecoration(
                  labelText: 'Minimum Price',
                )),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2022, 12, 12),
                      onChanged: (date) {}, onConfirm: (date) {
                    // print('confirm $date');
                    ddd = date;
                  }, currentTime: DateTime.now());
                },
                child: const Text(
                  'show date time picker (Chinese)',
                  style: TextStyle(color: Colors.blue),
                )),
            ElevatedButton(
                onPressed: () {
                  if (ddd == 0) {
                    Fluttertoast.showToast(
                        msg: 'Enter closing time for auction',
                        gravity: ToastGravity.CENTER);
                  } else {
                    addItem(_name.text, _desc.text, int.parse(_price.text));
                    Fluttertoast.showToast(
                        msg: 'Item successfully added for auction !',
                        gravity: ToastGravity.CENTER);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add this item')),
          ],
        ));
  }
}

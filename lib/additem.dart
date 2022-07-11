import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

void show(String s) {
  Fluttertoast.showToast(msg: s, gravity: ToastGravity.CENTER);
}

void addItem(String name, String description, int bidprice, String url) async {
  show('add item called');
  final docItem = FirebaseFirestore.instance.collection('items').doc();
  final json = {
    'title': name,
    'description': description,
    'bidprice': bidprice,
    'seller': FirebaseAuth.instance.currentUser!.email,
    'bidder': 'None',
    'imageURL': url,
    'close': ddd,
  };
  await docItem.set(json);
}

Future<void> addata(
    dynamic sampleImage2, String name, String des, int min_bid) async {
  show('Adding data $name');
  File sampleImage = File(sampleImage2.path);
  String fileName = sampleImage.path;
  fileName = '${FirebaseAuth.instance.currentUser!.email}$name.jpg';
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(fileName);
  UploadTask uploadTask = ref.putFile(sampleImage);
  String url = await ref.getDownloadURL();
  uploadTask.whenComplete(() {
    show('uploaded to $url');
    addItem(name, des, min_bid, url);
  });
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
  XFile? sampleImage;

  @override
  Widget build(BuildContext context) {
    ddd = 0;
    Widget x;
    if (sampleImage == null) {
      x = Image.network(
          'https://firebasestorage.googleapis.com/v0/b/auction-e9bad.appspot.com/o/Screenshot%202022-07-11%20113805.png?alt=media&token=ce78e847-adc4-49db-a3b6-7b2ec1336a0f',
          height: 100
          // height: 400,
          );
    } else {
      x = Image.file(File(sampleImage!.path),height: 150,);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add item for auction"),
        ),
        body: Column(
          children: [
            x,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                onPressed: () async {
                  // sampleImage =  getImage();
                  sampleImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                      setState(() {
                        
                      });
                },
                // child: sampleImage == null
                // ? const Text('Upload an image')
                child: const Text('Add Image'),
                // : Image.file(sampleImage!, height: 200.0, width: 300.0),
                // onPressed: getImage,
              ),
            ),
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
                  'Pick auction end Time',
                  style: TextStyle(color: Colors.blue),
                )),
            ElevatedButton(
                onPressed: () {
                  // print(sampleImage.runtimeType);
                  // if (ddd == 0) {
                  //   Fluttertoast.showToast(
                  //       msg: 'Enter closing time for auction',
                  //       gravity: ToastGravity.CENTER);
                  // } else {
                  // addItem(_name.text, _desc.text, int.parse(_price.text));
                  addata(
                    sampleImage,
                    _name.text,
                    _desc.text,
                    int.parse(_price.text),
                  );

                  // Navigator.pop(context);
                  // }
                },
                child: const Text('Add this item')),
          ],
        ));
  }
}

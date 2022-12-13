import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page pour les Images"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: pickImage,
              child: Text('Uploader une image'),
            ),
          ),
          DataInformation(),
        ]));
  }

  void pickImage() async {
    String imageURL = '';
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      DocumentReference imageDoc = await FirebaseFirestore.instance
          .collection('images')
          .add({'url': ''});
      Reference imageRef = FirebaseStorage.instance.ref(imageDoc.id + '.jpg');
      await imageRef.putFile(file);
      imageURL = await imageRef.getDownloadURL();
      imageDoc.update({'url': imageURL});
      // setState(() {});
    }
  }
}

class DataInformation extends StatefulWidget {
  @override
  _DataInformationState createState() => _DataInformationState();
}

class _DataInformationState extends State<DataInformation> {
  final Stream<QuerySnapshot> _datasStream =
      FirebaseFirestore.instance.collection('images').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _datasStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Quelque chose cest mal passé');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Chargement");
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
                title: Row(children: [
              Expanded(child: Text(data['url'])),
              // Expanded(
              //   child: Image.network(data['url']),
              // )
            ]));
          }).toList(),
        );
      },
    );
  }
}

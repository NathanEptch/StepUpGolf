import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonneesPage extends StatelessWidget {
  const DonneesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page pour les donnees"),
        ),
        body: Column(children: [
          AddData(),
        ]));
  }
}

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.black, width: 1.5),
              ),
              title: Row(children: [
                const Text('Firstname: '),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: firstnameController,
                  ),
                )
              ]),
            ),
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.black, width: 1.5),
              ),
              title: Row(children: [
                const Text('Lastname: '),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: lastnameController,
                  ),
                )
              ]),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  FirebaseFirestore.instance.collection('data').add({
                    'Firstname': firstnameController.value.text,
                    'Lastname': lastnameController.value.text,
                  });
                  firstnameController.clear();
                  lastnameController.clear();
                },
                child: const Text('Envoyer'))
          ],
        ));
  }
}

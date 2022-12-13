// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TempsReelPage extends StatelessWidget {
  const TempsReelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Page pour le temps reel"),
        ),
        body: Center(
          child: Column(
            children: [Expanded(child: DataInformation())],
          ),
        ));
  }
}

class DataInformation extends StatefulWidget {
  @override
  _DataInformationState createState() => _DataInformationState();
}

class _DataInformationState extends State<DataInformation> {
  final Stream<QuerySnapshot> _datasStream =
      FirebaseFirestore.instance.collection('data').snapshots();

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
              Expanded(child: Text(data['Firstname'])),
              Expanded(child: Text(data['Lastname'])),
              Expanded(
                child: Text(document.id),
              )
            ]));
          }).toList(),
        );
      },
    );
  }
}

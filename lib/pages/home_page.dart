import 'package:flutter/material.dart';
import 'temps_reel_page.dart';
import 'donnees_page.dart';
import 'image_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Step Up Golf 2022"),
        ),
        body: Center(
          child: Column( 
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              const Text("Bienvenue sur la page d'accueil de mon application"),
              const Padding(padding: EdgeInsets.only(top: 60)),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left :75, top: 60, right: 75, bottom: 60)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:(_, __, ___) => const ImagePage()
                    )
                  );
                },
                child: const Text("Image"),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left :70, top: 60, right: 70, bottom: 60)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:(_, __, ___) => const DonneesPage()
                    )
                  );
                },
                child: const Text("Données"),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(left :64, top: 60, right: 64, bottom: 60)),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:(_, __, ___) => const TempsReelPage()
                    )
                  );
                },
                child: const Text("Temps réel"),
              ),
            ],
          )
        ),
      );
  }
}
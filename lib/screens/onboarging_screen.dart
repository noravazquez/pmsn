import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:primer_proyecto/widgets/card_tecnm.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final data = const [
    CardTecnm(
        title: "Primer card",
        subtitle: "Hola",
        image: AssetImage("assets/image_default.png"),
        backgroundColor: Color.fromRGBO(0, 10, 56, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
    CardTecnm(
        title: "Primer card",
        subtitle: "Hola",
        image: AssetImage("assets/image_default.png"),
        backgroundColor: Color.fromRGBO(62, 142, 167, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
    CardTecnm(
        title: "Primer card",
        subtitle: "Hola",
        image: AssetImage("assets/image_default.png"),
        backgroundColor: Color.fromRGBO(0, 56, 5, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemBuilder: (int index) {
          return CardTec(data: data[index]);
        },
      ),
    );
  }
}

import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:primer_proyecto/widgets/card_tecnm.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final datos = const [
    CardTecnm(
        title: "Page 1",
        subtitle: "Subtitulo 1",
        image: AssetImage("assets/onboarding1.png"),
        backgroundColor: Color.fromRGBO(11, 27, 7, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
    CardTecnm(
        title: "Page 1",
        subtitle: "Subtitulo 1",
        image: AssetImage("assets/logo.png"),
        backgroundColor: Color.fromRGBO(75, 226, 61, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white),
    CardTecnm(
        title: "Page 1",
        subtitle: "Subtitulo 1",
        image: AssetImage("assets/logo.png"),
        backgroundColor: Color.fromRGBO(173, 87, 29, 1),
        titleColor: Colors.pink,
        subtitleColor: Colors.white)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: datos.map((e) => e.backgroundColor).toList(),
        itemBuilder: (index) {
          final dato = datos[index % datos.length];
          return CardTec(data: dato);
        },
      ),
    );
  }
}

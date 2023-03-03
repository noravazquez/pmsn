import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:primer_proyecto/widgets/card_tecnm.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(pages: [
            OnBoardingPage(size: size),
            Container(
              color: const Color.fromRGBO(229, 235, 210, 1),
            ),
            Container(
              color: const Color.fromRGBO(27, 32, 49, 1),
            ),
            Container(
              color: const Color.fromRGBO(205, 209, 201, 1),
            )
          ])
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: const Color.fromRGBO(11, 23, 7, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage("assets/onboarding1.png"),
            height: size.height * 0.5,
          ),
          Column(
            children: [
              Text(
                "Tecnologico Nacional de Mexico en Celaya",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Text(
                "Somos una Institución de Educación Superior, consolidada en la Región Laja-Bajío del Estado de Guanajuato, con oferta educativa a nivel profesional, maestrías y doctorados.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text("1/4"),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}

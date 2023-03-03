import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:primer_proyecto/models/model_on_boarding.dart';
import 'package:primer_proyecto/widgets/on_boarding_page_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: "assets/onboarding1.png",
              title: "TECNM en Celaya",
              subtitle:
                  "Somos una Institución de Educación Superior, consolidada en la Región Laja-Bajío del Estado de Guanajuato, con oferta educativa a nivel profesional, maestrías y doctorados.",
              counterText: "1/4",
              bgColor: Color.fromRGBO(11, 23, 7, 1),
              height: size.height)),
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: "assets/onboarding2.png",
              title: "Oferta educativa",
              subtitle:
                  "Ingeniería ambiental, ingeniería sistemas computacionales, ingeniería en electrónica, ingeniería química, ingeniería mecánica, ingeniería bioquímica, ingeniería industrial, ingeniería mecatrónica, licenciatura en administración, ingeniería en gestión empresarial",
              counterText: "2/4",
              bgColor: Color.fromRGBO(229, 235, 210, 1),
              height: size.height)),
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: "assets/onboarding3.png",
              title: "Conoce nuestras instalaciones",
              subtitle:
                  "Campus I: Antonio García Cubas, Pte #600 esq. Av. Tecnológico, Celaya, Gto. México. Campus II: Antonio García Cubas, Pte #1200 esq. Ignacio Borunda, Celaya, Gto. México",
              counterText: "3/4",
              bgColor: Color.fromRGBO(27, 32, 49, 1),
              height: size.height)),
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: "assets/onboarding4.png",
              title: "Rumbo al 65 aniversario",
              subtitle:
                  "Institución pública de educación, fundada en 1958, iniciando servicios desde secundaria técnica. Actualmente dedicada a la educación superior en niveles de licenciatura, maestría y doctorado.",
              counterText: "4/4",
              bgColor: Color.fromRGBO(205, 209, 201, 1),
              height: size.height))
    ];

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_on_boarding.dart';
import 'package:primer_proyecto/widgets/on_boarding_page_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

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
        height: size.height,
        background: LottieBuilder.network(
            "https://assets2.lottiefiles.com/packages/lf20_iomkzwwh.json"),
      )),
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
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () {
                int nextPage = controller.currentPage + 1;
                controller.animateToPage(page: nextPage);
              },
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  onPrimary: Colors.white),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color(0xff272727), shape: BoxShape.circle),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              count: 4,
              activeIndex: controller.currentPage,
              effect: const WormEffect(
                  activeDotColor: Color(0xff272727), dotHeight: 5.0),
            ),
          )
        ],
      ),
    );
  }

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}

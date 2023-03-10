import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_onboarding.dart';
import 'package:primer_proyecto/responsive.dart';
import 'package:primer_proyecto/widgets/on_boarding_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();
  int currentPage = 0;

  final pages = [
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'TECNM en Celaya',
            subtitle:
                'Somos una Institución de Educación Superior, consolidada en la Región Laja-Bajío del Estado de Guanajuato.',
            image: AssetImage("assets/onboarding1.png"),
            backgroundColor: Color.fromRGBO(11, 23, 7, 1),
            titleColor: Color.fromRGBO(229, 235, 210, 1),
            subtitleColor: Color.fromRGBO(229, 235, 210, 1),
            background: 'assets/animations/fireworks-explode.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Oferta educativa',
            subtitle:
                'Contamos con 9 ingenierías, 1 licenciatura y 12 posgrados',
            image: AssetImage("assets/onboarding2.png"),
            backgroundColor: Color.fromRGBO(229, 235, 210, 1),
            titleColor: Color.fromRGBO(27, 32, 49, 1),
            subtitleColor: Color.fromRGBO(27, 32, 49, 1),
            background: 'assets/animations/sparkles-burst.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Conoce nuestras instalaciones',
            subtitle:
                'Campus I: Antonio García Cubas, #600, Celaya, Gto. México. Campus II: Antonio García Cubas, #1200, Celaya, Gto. México',
            image: AssetImage("assets/onboarding3.png"),
            backgroundColor: Color.fromRGBO(27, 32, 49, 1),
            titleColor: Color.fromRGBO(205, 209, 201, 1),
            subtitleColor: Color.fromRGBO(205, 209, 201, 1),
            background: 'assets/animations/white-bubbles.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Rumbo al 65 aniversario',
            subtitle: 'Institución pública de educación, fundada en 1958.',
            image: AssetImage("assets/onboarding4.png"),
            backgroundColor: Color.fromRGBO(205, 209, 201, 1),
            titleColor: Color.fromRGBO(11, 23, 7, 1),
            subtitleColor: Color.fromRGBO(11, 23, 7, 1),
            background: 'assets/animations/confetti.json'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
            liquidController: controller,
            onPageChangeCallback: OnPageChangedCallback,
            enableSideReveal: true,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            pages: pages),
        Positioned(
          bottom: 50.0,
          child: OutlinedButton(
              onPressed: () {
                int nextPage = controller.currentPage + 1;
                controller.animateToPage(page: nextPage);
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.black26),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  onPrimary: Colors.white),
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: Icon(Icons.arrow_forward_ios),
              )),
        ),
        Responsive(
            mobile: MobileScreenSkip(),
            tablet: TabletDesktopScreenSkip(),
            desktop: TabletDesktopScreenSkip()),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: controller.currentPage,
            count: 4,
            effect: const WormEffect(
                spacing: 16,
                dotColor: Colors.black26,
                activeDotColor: Colors.black45),
            onDotClicked: (index) {
              controller.animateToPage(page: index);
            },
          ),
        )
      ]),
    );
  }

  OnPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}

class MobileScreenSkip extends StatelessWidget {
  const MobileScreenSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        left: 20,
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('SKIP', style: Theme.of(context).textTheme.bodyLarge)));
  }
}

class TabletDesktopScreenSkip extends StatelessWidget {
  const TabletDesktopScreenSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        right: 20,
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'SKIP',
              style: Theme.of(context).textTheme.bodyLarge,
            )));
  }
}

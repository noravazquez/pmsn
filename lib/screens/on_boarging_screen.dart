import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_onboarding.dart';
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
            title: 'Pagina 1',
            subtitle: 'Subtitulo 1',
            counterText: '1/4',
            image: AssetImage("assets/onboarding1.png"),
            backgroundColor: Colors.black,
            titleColor: Colors.white,
            subtitleColor: Colors.amber,
            background: 'assets/bubbles-lottie-animation.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Pagina 2',
            subtitle: 'Subtitulo 2',
            counterText: '2/4',
            image: AssetImage("assets/onboarding1.png"),
            backgroundColor: Colors.red,
            titleColor: Colors.white,
            subtitleColor: Colors.amber,
            background: 'assets/bubbles-lottie-animation.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Pagina 3',
            subtitle: 'Subtitulo 3',
            counterText: '3/4',
            image: AssetImage("assets/onboarding1.png"),
            backgroundColor: Colors.brown,
            titleColor: Colors.white,
            subtitleColor: Colors.amber,
            background: 'assets/bubbles-lottie-animation.json')),
    OnBoardingPageWidget(
        model: OnBoardingModel(
            title: 'Pagina 4',
            subtitle: 'Subtitulo 4',
            counterText: '4/4',
            image: AssetImage("assets/onboarding1.png"),
            backgroundColor: Colors.teal,
            titleColor: Colors.white,
            subtitleColor: Colors.amber,
            background: 'assets/bubbles-lottie-animation.json'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
            liquidController: controller,
            onPageChangeCallback: OnPageChangedCallback,
            enableSideReveal: true,
            waveType: WaveType.circularReveal,
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
        Positioned(
            top: 50,
            left: 20,
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('SKIP'))),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: controller.currentPage,
            count: 4,
            effect: const WormEffect(
                spacing: 16,
                dotColor: Colors.white54,
                activeDotColor: Colors.white),
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

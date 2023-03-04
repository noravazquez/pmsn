import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_on_boarding.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
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

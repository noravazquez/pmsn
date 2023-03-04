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
    return Scaffold(
      body: Stack(children: [
        LiquidSwipe(
            liquidController: controller,
            onPageChangeCallback: OnPageChangedCallback,
            enableSideReveal: true,
            waveType: WaveType.circularReveal,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            pages: [
              Container(
                color: Color.fromRGBO(11, 23, 7, 1),
                child: Center(
                  child: Text('Page 1'),
                ),
              ),
              Container(
                color: Color.fromRGBO(229, 235, 210, 1),
                child: Center(
                  child: Text('Page 2'),
                ),
              ),
              Container(
                color: Color.fromRGBO(27, 32, 49, 1),
                child: Center(
                  child: Text('Page 3'),
                ),
              ),
              Container(
                color: Color.fromRGBO(205, 209, 201, 1),
                child: Center(
                  child: Text('Page 4'),
                ),
              )
            ]),
        Positioned(
            bottom: 0,
            left: 16,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      int nextPage = controller.currentPage + 1;
                      controller.animateToPage(page: nextPage);
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black26),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        onPrimary: Colors.white),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: Icon(Icons.arrow_forward_ios),
                    )),
                AnimatedSmoothIndicator(
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
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('SKIP')),
              ],
            )),
      ]),
    );
  }

  OnPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}

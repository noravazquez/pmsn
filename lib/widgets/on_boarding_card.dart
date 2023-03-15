import 'package:flutter/material.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_onboarding.dart';
import 'package:primer_proyecto/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPageWidget extends StatelessWidget {
  OnBoardingPageWidget({required this.model, super.key});

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.backgroundColor,
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Responsive(
                  mobile: MobileScreen(model: model),
                  tablet: TabletDesktopScreen(model: model),
                  desktop: TabletDesktopScreen(model: model)),
            ),
          )
        ],
      ),
    );
  }
}

class MobileScreen extends StatelessWidget {
  MobileScreen({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(top: 20, child: Lottie.asset(model.background)),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageOnBoarding(model: model),
              Column(
                children: [
                  Text(
                    model.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: model.titleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.subtitle,
                    style: TextStyle(
                      color: model.subtitleColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 140,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabletDesktopScreen extends StatelessWidget {
  const TabletDesktopScreen({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(top: 20, child: Lottie.asset(model.background)),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageOnBoarding(model: model),
                ],
              ),
            )
          ],
        )),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(top: 20, child: Lottie.asset(model.background)),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model.title.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: model.titleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      model.subtitle,
                      style: TextStyle(
                        color: model.subtitleColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ImageOnBoarding extends StatelessWidget {
  const ImageOnBoarding({
    required this.model,
    super.key,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Image(image: model.image)),
          ],
        ),
      ],
    );
  }
}

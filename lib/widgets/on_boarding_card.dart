import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:primer_proyecto/models/model_onboarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({required this.model, super.key});

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
                        Column(
                          children: [
                            Text(
                              model.title.toUpperCase(),
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
                            )
                          ],
                        ),
                        Text(model.counterText)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
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
        SizedBox(height: 10.0),
      ],
    );
  }
}

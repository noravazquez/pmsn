import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (model.background != null) model.background!,
          Image(
            image: AssetImage(model.image),
            height: model.height * 0.5,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Text(
                model.subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(model.counterText),
          SizedBox(
            height: 80.0,
          )
        ],
      ),
    );
  }
}

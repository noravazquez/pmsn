import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String subtitle;
  final String counterText;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  CardData(
      {required this.title,
      required this.subtitle,
      required this.counterText,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      this.background});
}

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({required this.data, super.key});

  final CardData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Expanded(
                    child: Image(
                  image: data.image,
                )),
                const Spacer(flex: 1),
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  data.counterText,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

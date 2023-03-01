import 'package:flutter/material.dart';

class CardTecnm {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  const CardTecnm(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor});
}

class CardTec extends StatelessWidget {
  const CardTec({required this.data, super.key});

  final CardTecnm data;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

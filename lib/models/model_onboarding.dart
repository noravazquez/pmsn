import 'package:flutter/material.dart';

class OnBoardingModel {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final String background;

  OnBoardingModel(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      required this.background});
}

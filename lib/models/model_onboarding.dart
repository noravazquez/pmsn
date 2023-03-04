import 'dart:ui';
import 'package:flutter/material.dart';

class OnBoardingModel {
  final String title;
  final String subtitle;
  final String counterText;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final String background;

  OnBoardingModel(
      {required this.title,
      required this.subtitle,
      required this.counterText,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      required this.background});
}
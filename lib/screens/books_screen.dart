import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
    );
  }
}

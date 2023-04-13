import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/books_model.dart';

class ItemBookCard extends StatelessWidget {
  const ItemBookCard({super.key, required this.book});

  final BooksModel book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: Image.network(
          book.volumeInfo!.imageLinks!.smallThumbnail! ??
              'assets/cover_default.png',
          fit: BoxFit.fitWidth,
        ))
      ]),
    );
  }
}

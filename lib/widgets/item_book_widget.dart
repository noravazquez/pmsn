import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/books_model.dart';
import 'package:primer_proyecto/screens/book_detail_screen.dart';

class ItemBookCard extends StatelessWidget {
  const ItemBookCard({super.key, required this.book});

  final BooksModel book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            height: 150.0,
            child: Image.network(
              book.volumeInfo!.imageLinks!.thumbnail! ??
                  'assets/cover_default.png',
              fit: BoxFit.cover,
            )),
        SizedBox(
          height: 10.0,
        ),
        Text(
          book.volumeInfo!.title! ?? '',
          style: Theme.of(context).textTheme.labelLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          book.volumeInfo!.authors!.join(', ') ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BookDetailScreen(book: book),
              ));
            },
            child: Text('Ver detalles',
                style: Theme.of(context).textTheme.bodyMedium),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ))
      ]),
    );
  }
}

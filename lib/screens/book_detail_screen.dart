import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/books_model.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});

  final BooksModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.volumeInfo!.title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(),
            ),
            SizedBox(
              height: 300.0,
              child: Image.network(
                book.volumeInfo!.imageLinks!.thumbnail!,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.volumeInfo!.title!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    book.volumeInfo!.authors!.join(', '),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Publisher: ${book.volumeInfo!.publisher ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Published Date: ${book.volumeInfo!.publishedDate ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Page Count: ${book.volumeInfo!.pageCount ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Categories: ${book.volumeInfo!.categories?.join(', ') ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Average Rating: ${book.volumeInfo!.averageRating ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Language: ${book.volumeInfo!.language ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    book.volumeInfo!.description!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Preview Book'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

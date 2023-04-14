import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/books_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage('assets/fondo.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.4)),
              child: SizedBox(
                height: 200.0,
                child: Image.network(
                  book.volumeInfo!.imageLinks!.thumbnail!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  book.volumeInfo!.title!.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      //fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            offset: Offset(1.5, 1.5))
                      ]),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                book.volumeInfo!.authors!.join(', '),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(book.volumeInfo!.previewLink!));
                  link(book.volumeInfo!.previewLink!);
                },
                child: Text(
                  'Preview Book',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  link(String? s) {
    print(s);
  }
}

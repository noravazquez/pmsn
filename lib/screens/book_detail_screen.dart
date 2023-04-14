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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  book.volumeInfo?.authors?.join(', ') ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(book.volumeInfo!.previewLink!));
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
            RatingStars(
              rating: book.volumeInfo?.averageRating ?? 0,
            ),
            SizedBox(height: 20.0),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  Text(
                    'Descripción: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    book.volumeInfo!.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ]),
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
                    'Editorial: ${book.volumeInfo!.publisher ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Fecha de publicación: ${book.volumeInfo!.publishedDate ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Número de páginas: ${book.volumeInfo!.pageCount ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Lenguaje: ${book.volumeInfo!.language ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8.0, // Espacio entre categorías
                children: book.volumeInfo?.categories?.map((category) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }).toList() ??
                    [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Unknown',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  final double? rating;
  final double starSize;
  final Color starColor;

  const RatingStars({
    Key? key,
    this.rating,
    this.starSize = 30.0,
    this.starColor = Colors.yellow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating == null || rating == 0) {
      return Center(
          child: Text('Unknown', style: Theme.of(context).textTheme.bodyLarge));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildStar(1),
            _buildStar(2),
            _buildStar(3),
            _buildStar(4),
            _buildStar(5),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildStar(int index) {
    IconData iconData = Icons.star_border;
    Color iconColor = Colors.grey.shade400;

    if (index <= rating!) {
      iconData = Icons.star;
      iconColor = starColor;
    } else if (index - rating! <= 0.5) {
      iconData = Icons.star_half;
      iconColor = starColor;
    }

    return Icon(
      iconData,
      size: starSize,
      color: iconColor,
    );
  }
}

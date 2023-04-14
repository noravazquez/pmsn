import 'package:flutter/material.dart';
import 'package:primer_proyecto/models/books_model.dart';
import 'package:primer_proyecto/network/api_google_books.dart';
import 'package:primer_proyecto/widgets/item_book_widget.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        category,
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: FutureBuilder<List<BooksModel>?>(
        future: ApiGoogleBooks().getBooks(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al obtener los libros'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final book = snapshot.data![index];
                return Container(
                  key: UniqueKey(),
                  padding: EdgeInsets.all(10.0),
                  child: ItemBookCard(book: book),
                );
              },
            );
          } else {
            return Center(
              child: Text('No se encontraron libros'),
            );
          }
        },
      ),
    );
  }
}

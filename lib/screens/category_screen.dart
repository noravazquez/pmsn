import 'package:flutter/material.dart';
import 'package:primer_proyecto/screens/books_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Categorías', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Scrollbar(
        child: GridView.count(crossAxisCount: 2, children: const <Widget>[
          CategoryItem(
            title: 'Acción',
            category: 'action',
            imageUrl: 'https://static.wattpad.com/image/action-illo@3x.png',
          ),
          CategoryItem(
            title: 'Clásicos',
            category: 'classics',
            imageUrl: 'https://static.wattpad.com/image/newadult-illo@3x.png',
          ),
          CategoryItem(
            title: 'Fantasía',
            category: 'fantasy',
            imageUrl: 'https://static.wattpad.com/image/fantasy-illo@3x.png',
          ),
          CategoryItem(
            title: 'Ficción',
            category: 'fiction',
            imageUrl: 'https://static.wattpad.com/image/scifi-illo@3x.png',
          ),
          CategoryItem(
            title: 'Horror',
            category: 'horror',
            imageUrl: 'https://static.wattpad.com/image/mystery-illo@3x.png',
          ),
          CategoryItem(
            title: 'Humor',
            category: 'humor',
            imageUrl: 'https://static.wattpad.com/image/humor-illo@3x.png',
          ),
          CategoryItem(
            title: 'Poesía',
            category: 'poetry',
            imageUrl: 'https://static.wattpad.com/image/poetry-illo@3x.png',
          ),
          CategoryItem(
            title: 'Romance',
            category: 'romance',
            imageUrl: 'https://static.wattpad.com/image/romance-illo@3x.png',
          ),
        ]),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;

  const CategoryItem(
      {super.key,
      required this.title,
      required this.category,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BooksScreen(
            category: category,
          ),
        ));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              imageUrl,
              height: 140,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

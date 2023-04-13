import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:primer_proyecto/models/books_model.dart';

class ApiGoogleBooks {
  Future<List<BooksModel>?> getBooks(String category) async {
    var result = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$category'));
    var listJson = jsonDecode(result.body)['items'] as List;

    if (result.statusCode == 200) {
      return listJson.map((book) => BooksModel.fromMap(book)).toList();
    } else {
      return null;
    }
  }
}

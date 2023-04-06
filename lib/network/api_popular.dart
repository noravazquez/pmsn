import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:primer_proyecto/models/popular_model.dart';
import 'package:primer_proyecto/widgets/actors_movie.dart';

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=a312589363702724132147d44222494f&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }

  Future<String> getIdVideo(int idMovie) async {
    Uri linkVideo = Uri.parse('https://api.themoviedb.org/3/movie/' +
        idMovie.toString() +
        '/videos?api_key=a312589363702724132147d44222494f');
    var result = await http.get(linkVideo);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      print(listJSON[0]['key']);
      return listJSON[0]['key'];
    }
    return '';
  }

  Future<List<ActorsMovie>?> getAllAuthors(PopularModel modelito) async {
    Uri auxActores = Uri.parse('https://api.themoviedb.org/3/movie/' +
        modelito.id.toString() +
        '/credits?api_key=a312589363702724132147d44222494f');
    var result = await http.get(auxActores);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((actor) => ActorsMovie.fromMap(actor)).toList();
    }
    return null;
  }
}

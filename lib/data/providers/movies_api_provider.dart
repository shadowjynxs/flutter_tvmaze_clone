import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tvmaze/data/models/movies_model.dart';

class MoviesApiProvider {
  final String apiUrl = 'https://api.tvmaze.com/search/shows?q=';

  Future<List<MoviesModel>> fetchMovies() async {
    final response = await http.get(Uri.parse("${apiUrl}all"));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      
      return data.map((movieJson) => MoviesModel.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MoviesModel>> searchMovies(String query) async {
    final response = await http.get(Uri.parse("$apiUrl+$query"));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((movieJson) => MoviesModel.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

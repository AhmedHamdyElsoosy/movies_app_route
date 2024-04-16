import 'dart:convert';
import 'package:http/http.dart' as http;
import '../common/constants.dart';
import '../models/movie_model.dart';

class Api {
  static const baseUrl = "https://api.themoviedb.org/3/";
  var key = "?api_key=$apiKey";
  late String endPoint;
  late int movieId = movieId;

  final upComingApiUrl = "$baseUrl/movie/upcoming?api_key=$apiKey";
  final popularApiUrl = "$baseUrl/movie/popular?api_key=$apiKey";
  final topRatedApiUrl = "$baseUrl/movie/top_rated?api_key=$apiKey";
  late String similarApiUrl = "$baseUrl/movie/$Movie/similar?api_key=$apiKey";


  Future<List<Movie>> getMoviesByCategory(int categoryId) async {
    const String apiKey = '5ea3bcff98489a7a10d2f638eec23ae0';
    const String baseUrl = 'https://api.themoviedb.org/3';
    final String discoverMoviesUrl = '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$categoryId';
    try {
      final response = await http.get(Uri.parse(discoverMoviesUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        List<Movie> movies = results.map((movieData) {
          return Movie.fromMap(movieData);
        }).toList();
        return movies;
      } else {
        throw Exception('couldnt get movies');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }


  Future<List<Movie>> getSimilarMovies() async {
    final response = await http.get(Uri.parse(topRatedApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('coudlny get similar movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upComingApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('couldnt get upcoming movies');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('couldnt get popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('couldnt get top rated movies');
    }
  }
}
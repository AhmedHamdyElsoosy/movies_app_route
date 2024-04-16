import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';

class FirestoreService {
  final CollectionReference watchlistCollection =
  FirebaseFirestore.instance.collection('watchlist');

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> removeMovieFromWatchlist(String movieId) async {
    try {
      await firestore.collection('watchlist').doc(movieId).delete();
    } catch (e) {
      print('$e');
    }
  }

  Future<void> addMovieToWatchlist(Movie movie) async {
    try {
      Map<String, dynamic> movieData = movie.toMap();

      await watchlistCollection.add(movieData);
    } catch (error) {
      print('$error');
    }
  }

  Future<List<Movie>> getWatchlistMovies() async {
    try {
      QuerySnapshot querySnapshot = await watchlistCollection.get();
      List<Movie> movies = querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {

          String title = data['title'] ?? '';
          String posterPath = data['posterPath'] ?? '';
          String overview= data['overview'] ?? '';
          String releaseDate = data ['releaseDate'] ?? '';
          double voteAverage = data ['voteAverage'] ?? '';
          return Movie(
            id: data['id'],
            title: title,
            posterPath: posterPath ,
            overview: overview,
            releaseDate: releaseDate,
            voteAverage: voteAverage
          );
        } else {
          return Movie();
        }
      }).toList();
      return movies;
    } catch (e) {
      print('$e');
      throw e;
    }
  }
}
import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../firestore/firestore_service.dart';
import '../models/movie_model.dart';
import 'details_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});
  @override
  WatchListScreenState createState() => WatchListScreenState();
}

class WatchListScreenState extends State<WatchListScreen> {
  final FirestoreService firestoreService = FirestoreService();
  late List<Movie> watchlistMovies = [];

  @override
  void initState() {
    super.initState();
    _loadWatchlistMovies();
  }

  Future<void> _loadWatchlistMovies() async {
    final movies = await firestoreService.getWatchlistMovies();
    setState(() {
      watchlistMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: watchlistMovies.isEmpty
          ? const Center(child: Text("No Movies Added ..."))
          : ListView.builder(
        itemCount: watchlistMovies.length,
        itemBuilder: (context, index) {
          final movie = watchlistMovies[index];
          return Container(
            margin: const EdgeInsets.only(top: 7,bottom: 7,right: 15,left: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () {
                // Navigate to movie details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
                  ),
                );
              },
              child: Card(
                color: Colors.black54,
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Poster
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            '$imageUrl${movie.posterPath}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Movie Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.red
                            ),
                          ),
                          Text(
                            "Realease Date : ${movie.releaseDate}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red
                            ),
                          ),
                          const SizedBox(height: 4),
                          // You can add more details here if needed
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



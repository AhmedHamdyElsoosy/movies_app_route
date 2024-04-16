import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app_route/common/constants.dart';
import 'package:movies_app_route/models/movie_model.dart'; // Import your Movie model
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _searchMovies(String query) async {
    String apiKey = '5ea3bcff98489a7a10d2f638eec23ae0';
    String url = 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Movie _mapToMovie(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? "",
      title: map['title']?? "",
      backDropPath: map['backdrop_path']?? "",
      releaseDate: map['release_date']?? "",
      voteAverage: map['vote_average']?? "",
      overview: map['overview']?? "",
      posterPath: map['poster_path']?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.white),
                hintText: 'Search for movies ...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search,color: Colors.white,size: 25,),
                  onPressed: () {
                    String query = searchController.text.trim();
                    if (query.isNotEmpty) {
                      _searchMovies(query);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                // Convert Map to Movie object
                Movie movie = _mapToMovie(searchResults[index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: searchResults[index]['poster_path'] != null
                              ? Image.network(
                            '$imageUrl${searchResults[index]['poster_path']}',
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.movie),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            searchResults[index]['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

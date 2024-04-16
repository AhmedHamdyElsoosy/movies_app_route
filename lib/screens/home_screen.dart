import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_route/screens/details_screen.dart';
import '../common/constants.dart';
import '../firestore/firestore_service.dart';
import '../models/movie_model.dart';
import '../services/api_services.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    upcomingMovies = Api().getUpcomingMovies();
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Carousel
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;

                      return CarouselSlider.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index, movieIndex) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              DetailsScreen(movie: movie)));
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                              child: Image.network("$imageUrl${movie.posterPath}",fit: BoxFit.fill,),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio:0.25,
                            autoPlayInterval: const Duration(seconds: 3)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //Popular Movies
                const Text(
                  ' New Realeases',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 150,
                  child: FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      DetailsScreen(movie: movie)));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "$imageUrl${movie.backDropPath}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: IconButton(onPressed: (){
                                  FirestoreService().addMovieToWatchlist(movie);
                                },
                                    icon: const Icon(
                                      Icons.favorite,
                                      fill: 1,
                                      color: Colors.red,
                                      size: 20,)),
                              ),
                            ]
                          );
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  ' Recommended',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 150,
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      DetailsScreen(movie: movie)));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "$imageUrl${movie.backDropPath}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: IconButton(onPressed: (){
                                  FirestoreService().addMovieToWatchlist(movie);
                                },
                                    icon: const Icon(
                                      Icons.favorite,
                                      fill: 1,
                                      color: Colors.red,
                                      size: 20,)),
                              ),
                            ]
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


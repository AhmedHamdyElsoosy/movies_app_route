import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../models/movie_model.dart';
import '../services/api_services.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> similarMovies;

  @override
  void initState() {
    topRatedMovies = Api().getTopRatedMovies();
    similarMovies = Api().getSimilarMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(top: 16,left: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8)
              ),
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            ),
            backgroundColor: Colors.transparent,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                ),
                child: Image.network("$imageUrl${widget.movie.posterPath}",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(widget.movie.title,style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
                const SizedBox(height: 20,),
                Text(widget.movie.overview,style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            const Text("Realease Date : ",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),),
                            Text(widget.movie.releaseDate,style: const TextStyle(
                              fontSize: 16
                            ),),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("- Rating ",style: TextStyle(fontSize: 20),),
                      const Text("⭐ ",style: TextStyle(fontSize: 20),),
                      Text("${widget.movie.voteAverage.toStringAsFixed(1)}/10",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [Text(
                    textAlign: TextAlign.start,
                    'More Like This ...',
                    style: TextStyle(color: Colors.white),
                  ),]
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 150,
                  child: FutureBuilder(
                    future: similarMovies,
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
                        reverse: true,
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
                                  child: IconButton(onPressed: (){},
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
            )
            ),
          )
        ],
      ),
    );
  }
}
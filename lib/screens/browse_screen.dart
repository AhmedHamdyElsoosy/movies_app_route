import 'package:flutter/material.dart';
import 'package:movies_app_route/services/api_services.dart';
import '../models/category_genres_screen.dart';
import '../models/movie_model.dart';


class Category {
  final int id;
  final String name;
  final String imageLink;

  Category({required this.id, required this.name, required this.imageLink});
}

class BrowseCategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(id: 28, name: 'Action', imageLink: "assets/images/action.png"),
    Category(id: 12, name: 'Adventure', imageLink: "assets/images/adventure.png"),
    Category(id: 16, name: 'Animation', imageLink: "assets/images/animation.png"),
    Category(id: 35, name: 'Comedy', imageLink: "assets/images/comedy.png"),
    Category(id: 80, name: 'Crime', imageLink: "assets/images/crime.png"),
  ];

  BrowseCategoriesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 25),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final List<Movie> movies = await Api().getMoviesByCategory(categories[index].id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryMoviesScreen(
                        categoryName: categories[index].name,
                        movies: movies,
                      ),
                    ),
                  );
                },
                child: Container(

                  child: Card(
                    color: Colors.red[400],
                    elevation: 5,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              categories[index].imageLink,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(categories[index].name,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}





class Movie {
  final int id;
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Movie({
    this.id = 0,
     this.title = "",
     this.backDropPath = "",
     this.overview = "",
     this.posterPath = "",
     this.releaseDate = "",
     this.voteAverage = 0.0,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      backDropPath: map['backdrop_path'],
      releaseDate: map['release_date'],
      voteAverage: map['vote_average'],
      overview: map['overview'],
      posterPath: map['poster_path'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }
}
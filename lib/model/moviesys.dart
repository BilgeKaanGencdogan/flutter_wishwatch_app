import 'package:flutter_470project/Constants/ProjectStrings.dart';

import 'movie.dart';

class MovieSys {
  static Movie? searchedMovie;
  static List<Movie> movieList = [];
  static List<Movie> selectedMovies = [];

  static createMovieList() {
    movieList = [
      Movie(
          name: "APOKALIPTO",
          description: MovieDescription.apokalipto,
          director: "MEL GİBSON",
          duration: "2h 18m",
          image: MovieImages.apokaliptoImage,
          publishDate: "2006",
          category: "Action/Adventure",
          imdb: MovieImbd.apokaliptoImdb,
          stars: ["Rudy Youngblood", "Dalia Hernandez", "Raoul Trujillo"]),
      Movie(
          name: "DJANGO",
          description: MovieDescription.django,
          director: "QUENTİN TARANTİNO",
          duration: "2h 45m",
          image: MovieImages.djangotoImage,
          publishDate: "2012",
          category: "Western/Action",
          imdb: MovieImbd.djangotoImdb,
          stars: ["Christoph Waltz", "Leonardo DiCaprio", "Jamie Foxx"]),
      Movie(
          name: "THE HATEFUL EIGHT",
          description: MovieDescription.hatefuleight,
          director: "QUENTİN TARANTİNO",
          duration: "3h 7m",
          image: MovieImages.hatefuleightImage,
          publishDate: "2015",
          category: "Western/Thriller",
          imdb: MovieImbd.hatefuleightImdb,
          stars: ["Samuel L. Jackson", "Jennifer Jason Leigh", "Kurt Russel"]),
      Movie(
          name: "INCENDIES",
          description: MovieDescription.incendies,
          director: "Denis Villeneuve",
          duration: "2h 10m",
          image: MovieImages.incenidesImage,
          publishDate: "2010",
          category: "War/Mystery",
          imdb: MovieImbd.incenidesImdb,
          stars: [
            "Mélissa Désormeaux-Poulin",
            "Lubna Azabal",
            "Abdelghafour Elaaziz"
          ]),
      Movie(
          name: "JOHN WICK",
          description: MovieDescription.johnwick,
          director: "Chad Stahelski",
          duration: "2h 49m",
          image: MovieImages.johnwickImage,
          publishDate: "2023",
          category: "Action/Thriller",
          imdb: MovieImbd.johnwickImdb,
          stars: ["Keanu Reeves", "Bill Skarsgård", "Donnie Yen"]),
      Movie(
          name: "THE WOLF OF WALL STREET",
          description: MovieDescription.wolfofstreet,
          director: "Martin Scorsese",
          duration: "3h",
          image: MovieImages.wolfofstreetImage,
          publishDate: "2013",
          category: "Crime/Comedy",
          imdb: MovieImbd.wolfofstreetImdb,
          stars: ["Leonardo DiCaprio", "Matthew McConaughey", "Jonah Hill"]),
      Movie(
          name: "APOKALIPTO",
          description: MovieDescription.apokalipto,
          director: "MEL GİBSON",
          duration: "2h 18m",
          image: MovieImages.apokaliptoImage,
          publishDate: "2006",
          category: "Action/Adventure",
          imdb: MovieImbd.apokaliptoImdb,
          stars: ["Rudy Youngblood", "Dalia Hernandez", "Raoul Trujillo"]),
      Movie(
          name: "DJANGO",
          description: MovieDescription.django,
          director: "QUENTİN TARANTİNO",
          duration: "2h 45m",
          image: MovieImages.djangotoImage,
          publishDate: "2012",
          category: "Western/Action",
          imdb: MovieImbd.djangotoImdb,
          stars: ["Christoph Waltz", "Leonardo DiCaprio", "Jamie Foxx"]),
      Movie(
          name: "THE HATEFUL EIGHT",
          description: MovieDescription.hatefuleight,
          director: "QUENTİN TARANTİNO",
          duration: "3h 7m",
          image: MovieImages.hatefuleightImage,
          publishDate: "2015",
          category: "Western/Thriller",
          imdb: MovieImbd.hatefuleightImdb,
          stars: ["Samuel L. Jackson", "Jennifer Jason Leigh", "Kurt Russel"]),
      Movie(
          name: "INCENDIES",
          description: MovieDescription.incendies,
          director: "Denis Villeneuve",
          duration: "2h 10m",
          image: MovieImages.incenidesImage,
          publishDate: "2010",
          category: "War/Mystery",
          imdb: MovieImbd.incenidesImdb,
          stars: [
            "Mélissa Désormeaux-Poulin",
            "Lubna Azabal",
            "Abdelghafour Elaaziz"
          ]),
      Movie(
          name: "JOHN WICK",
          description: MovieDescription.johnwick,
          director: "Chad Stahelski",
          duration: "2h 49m",
          image: MovieImages.johnwickImage,
          publishDate: "2023",
          category: "Action/Thriller",
          imdb: MovieImbd.johnwickImdb,
          stars: ["Keanu Reeves", "Bill Skarsgård", "Donnie Yen"]),
      Movie(
          name: "THE WOLF OF WALL STREET",
          description: MovieDescription.wolfofstreet,
          director: "Martin Scorsese",
          duration: "3h",
          image: MovieImages.wolfofstreetImage,
          publishDate: "2013",
          category: "Crime/Comedy",
          imdb: MovieImbd.wolfofstreetImdb,
          stars: ["Leonardo DiCaprio", "Matthew McConaughey", "Jonah Hill"]),
    ];
  }

  static Movie movieAt(int index) {
    return movieList[index];
  }

  static Movie movieRemoveAt(int index) {
    return movieList.removeAt(index);
  }

  static bool movieMovie(Movie movie) {
    return movieList.remove(movie);
  }

  static int moiveListLength(List<Movie> movieList) {
    return movieList.length;
  }

  static List<Movie> findMovie(String key) {
    final result = key.isEmpty
        ? movieList
        : movieList
            .where((emp) =>
                emp.getName.toLowerCase().startsWith(key.toLowerCase()))
            .toList();
    return result;
  }
}

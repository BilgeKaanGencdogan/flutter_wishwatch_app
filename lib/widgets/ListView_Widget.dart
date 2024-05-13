import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services.dart
import 'package:flutter_470project/model/movie.dart';
import 'package:flutter_470project/model/moviesys.dart';
import 'package:go_router/go_router.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMovies(), // Load movies from JSON file
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Extract the first 10 movies
            final List<Movie> first10Movies = snapshot.data!.take(10).toList();
            return SizedBox(
              height: 300, // Set a fixed height
              child: ListViewBuilderForRecommended(
                selectedMovies: first10Movies,
              ),
            );
          }
        } else {
          return const CircularProgressIndicator(); // Show loading indicator
        }
      },
    );
  }

  Future<List<Movie>> loadMovies() async {
    // Load JSON data from file
    String jsonData = await rootBundle.loadString('assets/movie.json');
    // Parse JSON data into a list of movies
    List<Movie> movies =
        List<Movie>.from(jsonDecode(jsonData).map((x) => Movie.fromJson(x)));
    List<Movie> first10Movies = movies.take(10).toList();
    return first10Movies;
  }
}

class ListViewBuilderForRecommended extends StatelessWidget {
  const ListViewBuilderForRecommended({
    super.key,
    required this.selectedMovies,
  });

  final List<Movie> selectedMovies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: recommendedList(
            listData: selectedMovies[index],
            onAddPressed: (movie) {
              // Call the callback function when the add button is pressed
              // Pass the selected movie object to the callback function
              _handleAddMovie(context, movie);
            },
          ),
          onTap: () {
            final goRouter = GoRouter.of(context);
            goRouter.go('/movieDetail?'
                'name=${Uri.encodeComponent(selectedMovies[index].getName)}&'
                'description=${Uri.encodeComponent(selectedMovies[index].getDescription)}&'
                'director=${Uri.encodeComponent(selectedMovies[index].getDirector)}&'
                'duration=${Uri.encodeComponent(selectedMovies[index].getDuration)}&'
                'image=${Uri.encodeComponent(selectedMovies[index].getImage)}&'
                'publishDate=${Uri.encodeComponent(selectedMovies[index].getPublishDate)}&'
                'category=${Uri.encodeComponent(selectedMovies[index].getCategory)}&'
                'imdb=${Uri.encodeComponent(selectedMovies[index].getImbd)}&');
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: selectedMovies.length,
    );
  }

  void _handleAddMovie(BuildContext context, Movie movie) {
    MovieSys.selectedMovies.add(movie);
    //goToLibraryScreen(context, MovieSys.selectedMovies);
  }
}

class recommendedList extends StatelessWidget {
  const recommendedList({
    super.key,
    required this.listData,
    required this.onAddPressed,
  });

  final Movie listData;
  final Function(Movie)
      onAddPressed; // Callback function to handle add button press

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/${listData.getImage}'))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            listData.getName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
            highlightColor: Colors.red,
            onPressed: () {
              onAddPressed(listData);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

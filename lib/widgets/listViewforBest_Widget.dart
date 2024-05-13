import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_470project/model/movie.dart';
import 'package:flutter_470project/model/moviesys.dart';
import 'package:go_router/go_router.dart';

class ListViewWidgetForBest extends StatelessWidget {
  const ListViewWidgetForBest({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Movie> last10Movies = snapshot.data!;
            return SizedBox(
              height: 300,
              child: ListViewBuilderForBest(
                selectedMovies: last10Movies,
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Movie>> loadMovies() async {
    String jsonData = await rootBundle.loadString('assets/movie.json');
    List<Movie> movies =
        List<Movie>.from(jsonDecode(jsonData).map((x) => Movie.fromJson(x)));
    int lastIndex = movies.length - 1;
    int startIndex = lastIndex - 9;
    List<Movie> last10Movies = movies.sublist(startIndex, lastIndex + 1);
    return last10Movies;
  }
}

class ListViewBuilderForBest extends StatelessWidget {
  const ListViewBuilderForBest({
    super.key,
    required this.selectedMovies,
  });

  final List<Movie> selectedMovies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: BestList(
            listData: selectedMovies[index],
            onAddPressed: (movie) {
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
  }
}

class BestList extends StatelessWidget {
  const BestList({
    super.key,
    required this.listData,
    required this.onAddPressed,
  });

  final Movie listData;
  final Function(Movie) onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/${listData.image}'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listData.name!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 240,
                    child: Text(
                      listData.description!,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      onAddPressed(listData);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Constants/ProjectStrings.dart';
import '../model/movie.dart';
import '../model/moviesys.dart';

class ListViewWidgetForLibrary extends StatelessWidget {
  const ListViewWidgetForLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return ListViewBuilderForLibrary(
      selectedMovies: MovieSys.selectedMovies,
    );
  }
}

class ListViewBuilderForLibrary extends StatelessWidget {
  const ListViewBuilderForLibrary({
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
            listData: MovieSys.selectedMovies[index],
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteName.movieDetailRoute, arguments: {
              'name': MovieSys.selectedMovies[index].getName,
              'description': MovieSys.selectedMovies[index].getDescription,
              'director': MovieSys.selectedMovies[index].getDirector,
              'duration': MovieSys.selectedMovies[index].getDuration,
              'image': MovieSys.selectedMovies[index].getImage,
              'publishDate': MovieSys.selectedMovies[index].getPublishDate,
              'category': MovieSys.selectedMovies[index].getCategory,
              'imdb': MovieSys.selectedMovies[index].getImbd,
              'stars': MovieSys.selectedMovies[index].getStars
            });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: MovieSys.moiveListLength(MovieSys.selectedMovies),
    );
  }
}

class BestList extends StatelessWidget {
  const BestList({super.key, required this.listData});
  final Movie listData;

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
                        image: AssetImage(
                          'images/${listData.getImage}',
                        ))),
              )),
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
                    listData.getName,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 240,
                    child: Text(
                      listData.getDescription,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

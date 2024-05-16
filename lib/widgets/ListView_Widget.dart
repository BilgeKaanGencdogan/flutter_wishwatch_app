import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services.dart
import 'package:flutter_470project/model/movie.dart';
import 'package:flutter_470project/model/moviesys.dart';
import 'package:go_router/go_router.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    String jsonData = await rootBundle.loadString('assets/movie.json');
    List<Movie> movies =
        List<Movie>.from(jsonDecode(jsonData).map((x) => Movie.fromJson(x)));
    setState(() {
      _movies = movies.take(10).toList();
      _filteredMovies = _movies;
      _isLoading = false;
    });
  }

  void _filterMovies(String query) {
    List<Movie> filteredMovies = _movies.where((movie) {
      final name = movie.name?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredMovies = filteredMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        actions: [],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Movies...',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                _filterMovies(query);
              },
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListViewBuilderForRecommended(selectedMovies: _filteredMovies),
    );
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

class recommendedList extends StatelessWidget {
  const recommendedList({
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
      width: 160,
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              height: 165,
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

class MovieSearchDelegate extends SearchDelegate<Movie> {
  final List<Movie> movieList;

  MovieSearchDelegate(this.movieList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            Movie(
              name: '',
              description: '',
              director: '',
              duration: '',
              image: '',
              publishDate: '',
              category: '',
              imdb: '',
            ));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movieList.where((movie) {
      final name = movie.name?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final movie = results[index];
        return ListTile(
          title: Text(movie.name ?? ''),
          subtitle: Text(movie.category ?? ''),
          onTap: () {
            close(context, movie);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = movieList.where((movie) {
      final name = movie.name?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return ListTile(
          title: Text(movie.name ?? ''),
          subtitle: Text(movie.category ?? ''),
          onTap: () {
            query = movie.name ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}

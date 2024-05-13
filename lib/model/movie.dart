// ignore_for_file: public_member_api_docs, sort_constructors_first
class Movie {
  String? name;
  String? director;
  String? description;
  String? publishDate;
  String? duration;
  List<String>? stars;
  String? image;
  String? category;
  String? imdb;
  Movie(
      {this.name,
      this.director,
      this.description,
      this.publishDate,
      this.duration,
      this.stars,
      this.image,
      this.category,
      this.imdb});

  get getImbd => imdb;

  set setImbd(imdb) => this.imdb = imdb;

  get getCategory => category;

  set setCategory(category) => this.category = category;

  get getName => name;

  set setName(name) => this.name = name;

  get getDirector => director;

  set setDirector(director) => this.director = director;

  get getDescription => description;

  set setDescription(description) => this.description = description;

  get getPublishDate => publishDate;

  set setPublishDate(publishDate) => this.publishDate = publishDate;

  get getDuration => duration;

  set setDuration(duration) => this.duration = duration;

  List<String>? get getStars => stars;

  set setStars(List<String>? stars) => this.stars = stars;

  get getImage => image;

  set setimage(image) => this.image = image;

  @override
  @override
  String toString() {
    return 'Movie(name: $name, director: $director, description: $description, publishDate: $publishDate, duration: $duration, stars: $stars, image: $image, category: $category)';
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'],
      description: json['description'],
      director: json['director'],
      duration: json['duration'],
      image: json['image'],
      publishDate: json['publishDate'],
      category: json['category'],
      imdb: json['imdb'],
      stars: List<String>.from(json['stars']),
    );
  }
}

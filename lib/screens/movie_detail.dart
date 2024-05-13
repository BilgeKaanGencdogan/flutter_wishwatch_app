import 'package:flutter/material.dart';

class movieDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String director;
  final String duration;
  final String image;
  final String publishDate;
  final String category;
  final String imdb;
  final String stars;
  const movieDetailsScreen(
      {super.key,
      required this.name,
      required this.description,
      required this.director,
      required this.duration,
      required this.image,
      required this.publishDate,
      required this.category,
      required this.imdb,
      required this.stars});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Card(
                elevation: 5,
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/$image"),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(context, Icons.timer, duration),
                _buildInfoCard(context, Icons.star, imdb),
                _buildInfoCard(context, Icons.calendar_today, publishDate),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 18, height: 1.5),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String text) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Icon(
              icon,
              size: 45,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}

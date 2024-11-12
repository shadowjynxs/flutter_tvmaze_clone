import 'package:flutter/material.dart';
import 'package:tvmaze/data/models/movies_model.dart';
import 'package:tvmaze/presentation/screens/movie_screen.dart';

class MovieCard extends StatelessWidget {
  final MoviesModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieScreen(movie: movie),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: movie.imageUrlMedium != null && movie.imageUrlMedium!.isNotEmpty
                  ? Image.network(
                      movie.imageUrlMedium!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Center(
                      child: Icon(Icons.movie, size: 50),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                movie.language,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

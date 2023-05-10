import 'package:acinema_flutter_project/features/movies/data/models/movie_model.dart';
import 'package:acinema_flutter_project/features/movies/movie_card_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie, this.date}) : super(key: key);

  final MovieModel movie;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: MovieCardPage(
                    movie: movie,
                    date: date,
                  ),
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(milliseconds: 300)));
        },
        child: Stack(
          children: [
            Image.network(
              movie.smallImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${movie.name} (${movie.year})",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FixelDisplay"),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${movie.duration} mins',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: "FixelText"),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 16),
                            const SizedBox(width: 4.0),
                            Text(
                              movie.rating,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: "FixelText",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

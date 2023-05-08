import 'package:acinema_flutter_project/features/movies/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDescriptionWidget extends StatelessWidget {
  final MovieModel movie;

  const MovieDescriptionWidget({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "FixelDisplay",
            ),
          ),
          Text(
            movie.originalName,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "FixelDisplay",
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                '${movie.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontFamily: "FixelText",
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${movie.duration} min',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontFamily: "FixelText",
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Language:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.language,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Country:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.country,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Plot:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.plot,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Starring:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.starring,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Director:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.director,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Screenwriter:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.screenwriter,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Rating:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(movie.rating,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontFamily: "FixelText",
                  )),
              const SizedBox(
                width: 8,
              ),
              const Icon(Icons.star, color: Colors.yellow, size: 16),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Genre:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.genre,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Studio:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "FixelDisplay"),
          ),
          const SizedBox(height: 8),
          Text(
            movie.studio,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: "FixelText",
            ),
          ),
        ],
      ),
    );
  }
}

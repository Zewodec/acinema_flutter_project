import 'package:acinema_flutter_project/features/movies/data/repository/movie_repository.dart';
import 'package:acinema_flutter_project/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:acinema_flutter_project/features/movies/presentation/widgets/movie_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesCubit moviesCubit;

  @override
  void initState() {
    moviesCubit = MoviesCubit(MovieRepository(Dio()));
    moviesCubit.loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movies",
          style: TextStyle(
              fontFamily: "FixelDisplay", fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontFamily: "FixelText"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          BlocConsumer<MoviesCubit, MoviesState>(
            bloc: moviesCubit,
            listener: (context, state) {
              if (state is MoviesError) {
                Future.delayed(const Duration(seconds: 1)).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "MoviesError State:${state.errorMessage}",
                          style: const TextStyle(
                              fontFamily: "FixelText", color: Colors.white),
                        ))));
              }
            },
            builder: (context, state) {
              if (state is MoviesLoading) {
                return const CircularProgressIndicator(
                  color: Colors.green,
                );
              } else if (state is MoviesLoaded) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  ),
                );
              }
              Future.delayed(const Duration(seconds: 20))
                  .then((value) => moviesCubit.loadMovies());
              return const Text(
                "Error in getting Movies",
                style: TextStyle(
                    fontFamily: "FixelDisplay",
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              );
            },
          ),
        ],
      ),
    );
  }
}

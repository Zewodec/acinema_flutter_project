import 'package:acinema_flutter_project/features/movies/data/repository/movie_repository.dart';
import 'package:acinema_flutter_project/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:acinema_flutter_project/features/movies/presentation/widgets/movie_card.dart';
import 'package:acinema_flutter_project/features/movies_sessions/data/repository/movie_sessions_repository.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/sessions_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesCubit moviesCubit;
  late TextEditingController _searchFieldController;
  late SessionsCubit sessionsCubit;

  @override
  void initState() {
    GetIt.I.registerSingleton<SessionsCubit>(
        SessionsCubit(MovieSessionsRepository(Dio())));
    _searchFieldController = TextEditingController();
    moviesCubit = MoviesCubit(MovieRepository(Dio()));
    moviesCubit.loadMovies();
    sessionsCubit = GetIt.I.get<SessionsCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movies",
          style: TextStyle(
              fontFamily: "FixelDisplay", fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                  initialDate: dateTime,
                  firstDate: DateTime(2023, 05, 01),
                  lastDate: DateTime(2025));
                if (newDate == null) {
                  moviesCubit.loadMoviesWithDateOrName(
                      null, _searchFieldController.text);
                return;
              }

              setState(() {
                dateTime = newDate;
              });
              moviesCubit.loadMoviesWithDateOrName(
                  "${newDate.year}-${newDate.month}-${newDate.day}",
                  _searchFieldController.text);
            },
            icon: const Icon(Icons.date_range),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchFieldController,
              onEditingComplete: () {
                String? dateString =
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                if (_searchFieldController.text.isEmpty) {
                  dateString = null;
                }
                moviesCubit.loadMoviesWithDateOrName(
                    dateString, _searchFieldController.text);
              },
              decoration: const InputDecoration(
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
                Future.delayed(const Duration(seconds: 1)).then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      content: Text(
                        "MoviesError State:${state.errorMessage}",
                        style: const TextStyle(
                            fontFamily: "FixelText", color: Colors.white),
                      ),
                    ),
                  ),
                );
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
                    // Show cars as grid on page
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // Returns movie card on page
                      return MovieCard(
                        movie: state.movies[index],
                        date: dateTime,
                      );
                    },
                  ),
                );
              }
              // Reload Every 20 seconds for getting movies
              Future.delayed(const Duration(seconds: 20))
                  .then((value) => moviesCubit.loadMovies());
              return const Text(
                "Error in getting Movies\nCheck internet connection ;)",
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

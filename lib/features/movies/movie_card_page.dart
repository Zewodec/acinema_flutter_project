import 'package:acinema_flutter_project/features/movies/presentation/widgets/movie_description_widget.dart';
import 'package:acinema_flutter_project/features/movies_sessions/presentation/cubit/session_room_cubit.dart';
import 'package:acinema_flutter_project/features/movies_sessions/sessions_section.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../movies_sessions/room_session_section.dart';
import 'data/models/movie_model.dart';

class MovieCardPage extends StatefulWidget {
  final MovieModel movie;
  final DateTime? date;

  const MovieCardPage({super.key, required this.movie, this.date});

  @override
  State<MovieCardPage> createState() => _MovieCardPageState();
}

class _MovieCardPageState extends State<MovieCardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    GetIt.I.get<SessionRoomCubit>().loadStartState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [Tab(text: "Sessions"), Tab(text: "Description")],
        indicatorColor: Theme.of(context).colorScheme.primary,
        dividerColor: Theme.of(context).dividerColor,
        labelColor: Theme.of(context).colorScheme.primary,
        labelStyle: const TextStyle(
            fontFamily: "FixelDisplay",
            fontWeight: FontWeight.w600,
            fontSize: 14),
        unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelStyle: const TextStyle(
            fontFamily: "FixelDisplay",
            fontWeight: FontWeight.w300,
            fontSize: 12),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: [],
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.movie.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _buildMovieSessionTab(widget.movie.id.toString(), widget.date),
            _buildMovieDescriptionTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieDescriptionTab() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fixedSize: const Size(100, 50),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer),
                  onPressed: () => _launchTrailerUrl(
                      context, Uri.parse(widget.movie.trailer)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_indoor,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      Text(
                        "Watch Trailer!",
                        style: TextStyle(
                            fontFamily: "FixelText",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer),
                      )
                    ],
                  ),
                ),
              ),
              MovieDescriptionWidget(movie: widget.movie),
            ],
          ),
        )
      ],
    );
  }

  _launchTrailerUrl(var context, trailerURL) async {
    try {
      await launchUrl(trailerURL, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            "Can't open trailer!\n$e",
            style: TextStyle(
                fontFamily: "FixelText",
                color: Theme.of(context).colorScheme.onError),
          ),
        ),
      );
    }
  }

  Widget _buildMovieSessionTab(String movieId, DateTime? date) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 4),
      child: Column(
        children: [
          DateSessionSection(
            movieId: movieId,
            date: date,
          ),
          const SizedBox(
            height: 24,
          ),
          const Expanded(child: RoomSessionSection()),
        ],
      ),
    );
  }
}

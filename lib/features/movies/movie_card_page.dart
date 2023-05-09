import 'package:acinema_flutter_project/features/movies/presentation/widgets/movie_description_widget.dart';
import 'package:acinema_flutter_project/features/movies_sessions/sessions_section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/models/movie_model.dart';

class MovieCardPage extends StatefulWidget {
  final MovieModel movie;

  const MovieCardPage({super.key, required this.movie});

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
              actions: [
                IconButton(
                  onPressed: () => _launchTrailerUrl(
                      context, Uri.parse(widget.movie.trailer)),
                  icon: const Icon(Icons.camera_indoor),
                ),
              ],
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
            _buildMovieSessionTab(),
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

  Widget _buildMovieSessionTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            SessionSection(),
          ],
        ),
      ),
    );
  }
}

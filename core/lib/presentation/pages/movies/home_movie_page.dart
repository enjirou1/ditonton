import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/routes.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/provider/movies/movie_list_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/widgets/custom_animated_drawer.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-movies';

  const HomeMoviePage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomAnimatedDrawer(
        content: Scaffold(
          drawer: const CustomDrawer(routeName: HOME_MOVIES_ROUTE),
          appBar: AppBar(
            title: const Text('Movies'),
            actions: [
              IconButton(
                onPressed: () {
                  // FirebaseCrashlytics.instance.crash();
                  Navigator.pushNamed(context, SEARCH_MOVIE_ROUTE);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubHeading(
                    title: 'Now Playing',
                    onTap: () => Navigator.pushNamed(context, NOW_PLAYING_ROUTE),
                  ),
                  Consumer<MovieListNotifier>(builder: (context, data, child) {
                    final state = data.nowPlayingState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(data.nowPlayingMovies);
                    } else {
                      return const Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
                  ),
                  Consumer<MovieListNotifier>(builder: (context, data, child) {
                    final state = data.popularMoviesState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(data.popularMovies);
                    } else {
                      return const Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.pushNamed(context, TOP_RATED_MOVIES_ROUTE),
                  ),
                  Consumer<MovieListNotifier>(builder: (context, data, child) {
                    final state = data.topRatedMoviesState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(data.topRatedMovies);
                    } else {
                      return const Text('Failed');
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

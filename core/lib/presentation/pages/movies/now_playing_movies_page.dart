import 'package:core/presentation/bloc/movies/movies_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';

  @override
  _NowPlayingMoviesPageState createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      // Provider.of<NowPlayingMoviesNotifier>(context, listen: false).fetchNowPlayingMovies()
      context.read<NowPlayingMoviesBloc>().add(GetNowPlayingMoviesEvent())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        /* child: Consumer<NowPlayingMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ), */
        child: BlocBuilder<NowPlayingMoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is MoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              ); 
            }
          },
        )
      ),
    );
  }
}

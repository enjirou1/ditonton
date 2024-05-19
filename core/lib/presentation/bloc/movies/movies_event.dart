part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends MoviesEvent {
  final int id;

  const GetMovieDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetMovieRecommendationsEvent extends MoviesEvent {
  final int id;

  const GetMovieRecommendationsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlistEvent extends MoviesEvent {
  final MovieDetail movie;

  const AddMovieWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchlistEvent extends MoviesEvent {
  final MovieDetail movie;

  const RemoveMovieWatchlistEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatusEvent extends MoviesEvent {
  final int id;

  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}

class GetWatchlistMoviesEvent extends MoviesEvent {}
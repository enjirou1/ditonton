part of 'movies_bloc.dart';

@immutable
sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

final class MoviesEmpty extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class MoviesHasData extends MoviesState {
  final List<Movie> result;

  const MoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

final class MoviesHomeHasData extends MoviesState {
  final List<Movie> nowPlayingMovies;
  final bool isLoadingNowPlayingMovies;
  final List<Movie> popularMovies;
  final bool isLoadingPopularMovies;
  final List<Movie> topRatedMovies;
  final bool isLoadingTopRatedMovies;

  const MoviesHomeHasData({
    this.nowPlayingMovies = const [],
    this.isLoadingNowPlayingMovies = false,
    this.popularMovies = const [], 
    this.isLoadingPopularMovies = false,
    this.topRatedMovies = const [],
    this.isLoadingTopRatedMovies = false
  });

  MoviesHomeHasData copyWith({
    List<Movie>? nowPlayingMovies,
    bool? isLoadingNowPlayingMovies,
    List<Movie>? popularMovies,
    bool? isLoadingPopularMovies,
    List<Movie>? topRatedMovies,
    bool? isLoadingTopRatedMovies
  }) {
    return MoviesHomeHasData(
      isLoadingNowPlayingMovies: isLoadingNowPlayingMovies ?? this.isLoadingNowPlayingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      isLoadingPopularMovies: isLoadingPopularMovies ?? this.isLoadingPopularMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      isLoadingTopRatedMovies: isLoadingTopRatedMovies ?? this.isLoadingTopRatedMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies
    );
  }

  @override
  List<Object> get props => [
    nowPlayingMovies,
    isLoadingNowPlayingMovies,
    popularMovies, 
    isLoadingPopularMovies,
    topRatedMovies,
    isLoadingTopRatedMovies
  ];
}

final class MoviesDetailHasData extends MoviesState {
  final MovieDetail? movie;
  final bool isLoadingMovie;
  final List<Movie> movieRecommendations;
  final bool isLoadingRecommendations;
  final bool isAddedToWatchlist;
  final String message;

  const MoviesDetailHasData({
    this.movie, 
    this.isLoadingMovie = false,
    this.movieRecommendations = const [], 
    this.isLoadingRecommendations = false,
    this.isAddedToWatchlist = false,
    this.message = ""
  });

  MoviesDetailHasData copyWith({
    MovieDetail? movie,
    bool? isLoadingMovie,
    List<Movie>? movieRecommendations,
    bool? isLoadingRecommendations,
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return MoviesDetailHasData(
      movie: movie ?? this.movie,
      isLoadingMovie: isLoadingMovie ?? this.isLoadingMovie,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      isLoadingRecommendations: isLoadingRecommendations ?? this.isLoadingRecommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [
    movie, 
    isLoadingMovie,
    movieRecommendations, 
    isLoadingRecommendations,
    isAddedToWatchlist, 
    message
  ];
}
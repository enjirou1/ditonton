import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MoviesEmpty()) {
    on<GetNowPlayingMoviesEvent>((event, emit) async {
      emit(MoviesLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class PopularMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MoviesEmpty()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      emit(MoviesLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class TopRatedMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MoviesEmpty()) {
    on<GetTopRatedMoviesEvent>((event, emit) async {
      emit(MoviesLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class WatchlistMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(MoviesEmpty()) {
    on<GetWatchlistMoviesEvent>((event, emit) async {
      emit(MoviesLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          emit(MoviesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class HomeMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  HomeMoviesBloc({
    required this.getNowPlayingMovies, 
    required this.getPopularMovies, 
    required this.getTopRatedMovies
  }) : super(MoviesEmpty()) {
    on<GetNowPlayingMoviesEvent>((event, emit) async {
      if (state is MoviesHomeHasData) {
        MoviesHomeHasData currentState = state as MoviesHomeHasData;
        emit(currentState.copyWith(isLoadingNowPlayingMovies: true));
      } else {
        emit(MoviesHomeHasData(isLoadingNowPlayingMovies: true));
      }

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          if (state is MoviesHomeHasData) {
            MoviesHomeHasData currentState = state as MoviesHomeHasData;
            emit(currentState.copyWith(isLoadingNowPlayingMovies: false, nowPlayingMovies: data));
          } else {
            emit(MoviesHomeHasData(nowPlayingMovies: data, isLoadingNowPlayingMovies: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetPopularMoviesEvent>((event, emit) async {
      if (state is MoviesHomeHasData) {
        MoviesHomeHasData currentState = state as MoviesHomeHasData;
        emit(currentState.copyWith(isLoadingPopularMovies: true));
      } else {
        emit(MoviesHomeHasData(isLoadingPopularMovies: true));
      }

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          if (state is MoviesHomeHasData) {
            MoviesHomeHasData currentState = state as MoviesHomeHasData;
            emit(currentState.copyWith(isLoadingPopularMovies: false, popularMovies: data));
          } else {
            emit(MoviesHomeHasData(popularMovies: data, isLoadingPopularMovies: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetTopRatedMoviesEvent>((event, emit) async {
      if (state is MoviesHomeHasData) {
        MoviesHomeHasData currentState = state as MoviesHomeHasData;
        emit(currentState.copyWith(isLoadingTopRatedMovies: true));
      } else {
        emit(MoviesHomeHasData(isLoadingTopRatedMovies: true));
      }

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          if (state is MoviesHomeHasData) {
            MoviesHomeHasData currentState = state as MoviesHomeHasData;
            emit(currentState.copyWith(isLoadingTopRatedMovies: false, topRatedMovies: data));
          } else {
            emit(MoviesHomeHasData(topRatedMovies: data, isLoadingTopRatedMovies: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class DetailMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  DetailMoviesBloc({
    required this.getMovieDetail, 
    required this.getMovieRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus
  }) : super(MoviesEmpty()) {
    on<GetMovieDetailEvent>((event, emit) async {
      if (state is MoviesDetailHasData) {
        MoviesDetailHasData currentState = state as MoviesDetailHasData;
        emit(currentState.copyWith(isLoadingMovie: true));
      } else {
        emit(const MoviesDetailHasData(isLoadingMovie: true));
      }

      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          if (state is MoviesDetailHasData) {
            MoviesDetailHasData currentState = state as MoviesDetailHasData;
            emit(currentState.copyWith(isLoadingMovie: false, movie: data));
          } else {
            emit(MoviesDetailHasData(isLoadingMovie: false, movie: data));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetMovieRecommendationsEvent>((event, emit) async {
      if (state is MoviesDetailHasData) {
        MoviesDetailHasData currentState = state as MoviesDetailHasData;
        emit(currentState.copyWith(isLoadingRecommendations: true));
      } else {
        emit(const MoviesDetailHasData(isLoadingRecommendations: true));
      }

      final result = await getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (data) {
          if (state is MoviesDetailHasData) {
            MoviesDetailHasData currentState = state as MoviesDetailHasData;
            emit(currentState.copyWith(isLoadingRecommendations: false, movieRecommendations: data));
          } else {
            emit(MoviesDetailHasData(isLoadingRecommendations: false, movieRecommendations: data));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
    
    on<AddMovieWatchlistEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (successMessage) async {
          if (state is MoviesDetailHasData) {
            MoviesDetailHasData currentState = state as MoviesDetailHasData;
            emit(currentState.copyWith(message: successMessage));
          } else {
            emit(MoviesDetailHasData(message: successMessage));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<RemoveMovieWatchlistEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(MoviesError(failure.message));
        }, 
        (successMessage) async {
          if (state is MoviesDetailHasData) {
            MoviesDetailHasData currentState = state as MoviesDetailHasData;
            emit(currentState.copyWith(message: successMessage));
          } else {
            emit(MoviesDetailHasData(message: successMessage));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<LoadWatchlistStatusEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      if (state is MoviesDetailHasData) {
        MoviesDetailHasData currentState = state as MoviesDetailHasData;
        emit(currentState.copyWith(isAddedToWatchlist: result));
      } else {
        emit(MoviesDetailHasData(isAddedToWatchlist: result));
      }
      
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
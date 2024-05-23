import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist.dart';
import 'package:core/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_series_event.dart';
part 'tv_series_state.dart';

class AiringTodayTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetAiringTodayTvSeries _getAiringTodayTvSeries;

  AiringTodayTvSeriesBloc(this._getAiringTodayTvSeries) : super(TvSeriesEmpty()) {
    on<GetAiringTodayTvSeriesEvent>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getAiringTodayTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class PopularTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super(TvSeriesEmpty()) {
    on<GetPopularTvSeriesEvent>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class TopRatedTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this._getTopRatedTvSeries) : super(TvSeriesEmpty()) {
    on<GetTopRatedTvSeriesEvent>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class WatchlistTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries) : super(TvSeriesEmpty()) {
    on<GetWatchlistTvSeriesEvent>((event, emit) async {
      emit(TvSeriesLoading());

      final result = await _getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          emit(TvSeriesHasData(data));
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class HomeTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  HomeTvSeriesBloc({
    required this.getAiringTodayTvSeries, 
    required this.getPopularTvSeries, 
    required this.getTopRatedTvSeries
  }) : super(TvSeriesEmpty()) {
    on<GetAiringTodayTvSeriesEvent>((event, emit) async {
      if (state is TvSeriesHomeHasData) {
        TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
        emit(currentState.copyWith(isLoadingAiringTodayTvSeries: true));
      } else {
        emit(const TvSeriesHomeHasData(isLoadingAiringTodayTvSeries: true));
      }

      final result = await getAiringTodayTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          if (state is TvSeriesHomeHasData) {
            TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
            emit(currentState.copyWith(isLoadingAiringTodayTvSeries: false, airingTodayTvSeries: data));
          } else {
            emit(TvSeriesHomeHasData(airingTodayTvSeries: data, isLoadingAiringTodayTvSeries: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetPopularTvSeriesEvent>((event, emit) async {
      if (state is TvSeriesHomeHasData) {
        TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
        emit(currentState.copyWith(isLoadingPopularTvSeries: true));
      } else {
        emit(const TvSeriesHomeHasData(isLoadingPopularTvSeries: true));
      }

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          if (state is TvSeriesHomeHasData) {
            TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
            emit(currentState.copyWith(isLoadingPopularTvSeries: false, popularTvSeries: data));
          } else {
            emit(TvSeriesHomeHasData(popularTvSeries: data, isLoadingPopularTvSeries: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<GetTopRatedTvSeriesEvent>((event, emit) async {
      if (state is TvSeriesHomeHasData) {
        TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
        emit(currentState.copyWith(isLoadingTopRatedTvSeries: true));
      } else {
        emit(const TvSeriesHomeHasData(isLoadingTopRatedTvSeries: true));
      }

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          if (state is TvSeriesHomeHasData) {
            TvSeriesHomeHasData currentState = state as TvSeriesHomeHasData;
            emit(currentState.copyWith(isLoadingTopRatedTvSeries: false, topRatedTvSeries: data));
          } else {
            emit(TvSeriesHomeHasData(topRatedTvSeries: data, isLoadingTopRatedTvSeries: false));
          }
        } 
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class DetailTvSeriesBloc extends Bloc<TvSeriesEvent, TvSeriesState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;
  final GetWatchListStatusTvSeries getWatchListStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  DetailTvSeriesBloc({
    required this.getTvSeriesDetail, 
    required this.getTvSeriesRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus
  }) : super(TvSeriesEmpty()) {
    on<GetTvSeriesDetailEvent>((event, emit) async {
      /* if (state is TvSeriesDetailHasData) {
        TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
        emit(currentState.copyWith(isLoadingTvSeries: true));
      } else {
        emit(const TvSeriesDetailHasData(isLoadingTvSeries: true));
      } */
      emit(const TvSeriesDetailHasData(isLoadingTvSeries: true));

      final result = await getTvSeriesDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          if (state is TvSeriesDetailHasData) {
            TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
            emit(currentState.copyWith(isLoadingTvSeries: false, tvSeries: data));
          } else {
            emit(TvSeriesDetailHasData(isLoadingTvSeries: false, tvSeries: data));
          }
        } 
      );
    }/* , transformer: debounce(const Duration(milliseconds: 500)) */);

    on<GetTvSeriesRecommendationsEvent>((event, emit) async {
      if (state is TvSeriesDetailHasData) {
        TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
        emit(currentState.copyWith(isLoadingRecommendations: true));
      } else {
        emit(const TvSeriesDetailHasData(isLoadingRecommendations: true));
      }

      final result = await getTvSeriesRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (data) {
          if (state is TvSeriesDetailHasData) {
            TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
            emit(currentState.copyWith(isLoadingRecommendations: false, tvSeriesRecommendations: data));
          } else {
            emit(TvSeriesDetailHasData(isLoadingRecommendations: false, tvSeriesRecommendations: data));
          }
        } 
      );
    }/* , transformer: debounce(const Duration(milliseconds: 500)) */);
    
    on<AddTvSeriesWatchlistEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvSeries);

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (successMessage) async {
          if (state is TvSeriesDetailHasData) {
            TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
            emit(currentState.copyWith(message: successMessage));
          } else {
            emit(TvSeriesDetailHasData(message: successMessage));
          }
        } 
      );
    }/* , transformer: debounce(const Duration(milliseconds: 500)) */);

    on<RemoveTvSeriesWatchlistEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvSeries);

      result.fold(
        (failure) {
          emit(TvSeriesError(failure.message));
        }, 
        (successMessage) async {
          if (state is TvSeriesDetailHasData) {
            TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
            emit(currentState.copyWith(message: successMessage));
          } else {
            emit(TvSeriesDetailHasData(message: successMessage));
          }
        } 
      );
    }/* , transformer: debounce(const Duration(milliseconds: 500)) */);

    on<LoadWatchlistStatusEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      if (state is TvSeriesDetailHasData) {
        TvSeriesDetailHasData currentState = state as TvSeriesDetailHasData;
        emit(currentState.copyWith(isAddedToWatchlist: result));
      } else {
        emit(TvSeriesDetailHasData(isAddedToWatchlist: result));
      }
      
    }/* , transformer: debounce(const Duration(milliseconds: 500)) */);
  }
}
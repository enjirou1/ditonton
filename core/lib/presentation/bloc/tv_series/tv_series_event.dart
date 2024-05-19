part of 'tv_series_bloc.dart';

@immutable
sealed class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeriesDetailEvent extends TvSeriesEvent {
  final int id;

  const GetTvSeriesDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetTvSeriesRecommendationsEvent extends TvSeriesEvent {
  final int id;

  const GetTvSeriesRecommendationsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvSeriesWatchlistEvent extends TvSeriesEvent {
  final TvSeriesDetail tvSeries;

  const AddTvSeriesWatchlistEvent(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RemoveTvSeriesWatchlistEvent extends TvSeriesEvent {
  final TvSeriesDetail tvSeries;

  const RemoveTvSeriesWatchlistEvent(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistStatusEvent extends TvSeriesEvent {
  final int id;

  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAiringTodayTvSeriesEvent extends TvSeriesEvent {}

class GetPopularTvSeriesEvent extends TvSeriesEvent {}

class GetTopRatedTvSeriesEvent extends TvSeriesEvent {}

class GetWatchlistTvSeriesEvent extends TvSeriesEvent {}
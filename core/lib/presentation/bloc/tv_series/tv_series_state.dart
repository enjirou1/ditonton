part of 'tv_series_bloc.dart';

@immutable
sealed class TvSeriesState extends Equatable {
  const TvSeriesState();

  @override
  List<Object?> get props => [];
}

final class TvSeriesEmpty extends TvSeriesState {}

final class TvSeriesLoading extends TvSeriesState {}

final class TvSeriesError extends TvSeriesState {
  final String message;

  const TvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvSeriesHasData extends TvSeriesState {
  final List<TvSeries> result;

  const TvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

final class TvSeriesHomeHasData extends TvSeriesState {
  final List<TvSeries> airingTodayTvSeries;
  final bool isLoadingAiringTodayTvSeries;
  final List<TvSeries> popularTvSeries;
  final bool isLoadingPopularTvSeries;
  final List<TvSeries> topRatedTvSeries;
  final bool isLoadingTopRatedTvSeries;

  const TvSeriesHomeHasData({
    this.airingTodayTvSeries = const [],
    this.isLoadingAiringTodayTvSeries = false,
    this.popularTvSeries = const [], 
    this.isLoadingPopularTvSeries = false,
    this.topRatedTvSeries = const [],
    this.isLoadingTopRatedTvSeries = false
  });

  TvSeriesHomeHasData copyWith({
    List<TvSeries>? airingTodayTvSeries,
    bool? isLoadingAiringTodayTvSeries,
    List<TvSeries>? popularTvSeries,
    bool? isLoadingPopularTvSeries,
    List<TvSeries>? topRatedTvSeries,
    bool? isLoadingTopRatedTvSeries
  }) {
    return TvSeriesHomeHasData(
      isLoadingAiringTodayTvSeries: isLoadingAiringTodayTvSeries ?? this.isLoadingAiringTodayTvSeries,
      airingTodayTvSeries: airingTodayTvSeries ?? this.airingTodayTvSeries,
      isLoadingPopularTvSeries: isLoadingPopularTvSeries ?? this.isLoadingPopularTvSeries,
      popularTvSeries: popularTvSeries ?? this.popularTvSeries,
      isLoadingTopRatedTvSeries: isLoadingTopRatedTvSeries ?? this.isLoadingTopRatedTvSeries,
      topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries
    );
  }

  @override
  List<Object> get props => [
    airingTodayTvSeries,
    isLoadingAiringTodayTvSeries,
    popularTvSeries, 
    isLoadingPopularTvSeries,
    topRatedTvSeries,
    isLoadingTopRatedTvSeries
  ];
}

final class TvSeriesDetailHasData extends TvSeriesState {
  final TvSeriesDetail? tvSeries;
  final bool isLoadingTvSeries;
  final List<TvSeries> tvSeriesRecommendations;
  final bool isLoadingRecommendations;
  final bool isAddedToWatchlist;
  final String message;

  const TvSeriesDetailHasData({
    this.tvSeries, 
    this.isLoadingTvSeries = false,
    this.tvSeriesRecommendations = const [], 
    this.isLoadingRecommendations = false,
    this.isAddedToWatchlist = false,
    this.message = ""
  });

  TvSeriesDetailHasData copyWith({
    TvSeriesDetail? tvSeries,
    bool? isLoadingTvSeries,
    List<TvSeries>? tvSeriesRecommendations,
    bool? isLoadingRecommendations,
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return TvSeriesDetailHasData(
      tvSeries: tvSeries ?? this.tvSeries,
      isLoadingTvSeries: isLoadingTvSeries ?? this.isLoadingTvSeries,
      tvSeriesRecommendations: tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      isLoadingRecommendations: isLoadingRecommendations ?? this.isLoadingRecommendations,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [
    tvSeries, 
    isLoadingTvSeries,
    tvSeriesRecommendations, 
    isLoadingRecommendations,
    isAddedToWatchlist, 
    message
  ];
}
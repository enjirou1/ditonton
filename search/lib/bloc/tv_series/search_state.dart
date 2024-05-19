part of 'search_bloc.dart';

@immutable
sealed class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  const SearchTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
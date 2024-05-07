import '../../../../lib/data/models/tv_series/tv_series_model.dart';
import '../../../../lib/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ['1', '2', '3'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: const ['1', '2', '3'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}

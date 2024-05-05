import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/top_rated_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    notifier = TopRatedTvSeriesNotifier(getTopRatedTvSeries: mockGetTopRatedTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeriesList, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      verify(mockGetAiringTodayTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

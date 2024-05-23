import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tv_series/dummy_objects.dart';
import 'tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetWatchlistTvSeries,
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetWatchListStatusTvSeries,
])
void main() {
  late HomeTvSeriesBloc homeTvSeriesBloc;
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late AiringTodayTvSeriesBloc airingTodayTvSeriesBloc;
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;
  late MockGetWatchListStatusTvSeries mockGetWatchlistStatus;

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
  const tId = 1;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();
    mockGetWatchlistStatus = MockGetWatchListStatusTvSeries();
    
    homeTvSeriesBloc = HomeTvSeriesBloc(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries, 
      getPopularTvSeries: mockGetPopularTvSeries, 
      getTopRatedTvSeries: mockGetTopRatedTvSeries
    );
    detailTvSeriesBloc = DetailTvSeriesBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail, 
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations, 
      saveWatchlist: mockSaveWatchlist, 
      removeWatchlist: mockRemoveWatchlist, 
      getWatchListStatus: mockGetWatchlistStatus
    );
    airingTodayTvSeriesBloc = AiringTodayTvSeriesBloc(mockGetAiringTodayTvSeries);
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  blocTest<HomeTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHomeHasData] when data airing today is gotten successfully',
    build: () {
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return homeTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodayTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesHomeHasData(isLoadingAiringTodayTvSeries: true),
      TvSeriesHomeHasData(airingTodayTvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    }
  );

  blocTest<HomeTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHomeHasData] when data popular tv series is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return homeTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesHomeHasData(isLoadingPopularTvSeries: true),
      TvSeriesHomeHasData(popularTvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    }
  );

  blocTest<HomeTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHomeHasData] when data top rated tv series is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return homeTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesHomeHasData(isLoadingTopRatedTvSeries: true),
      TvSeriesHomeHasData(topRatedTvSeries: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    }
  );

  blocTest<HomeTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHomeHasData, TvSeriesError] when data airing today is gotten unsuccessful',
    build: () {
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return homeTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetAiringTodayTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesHomeHasData(isLoadingAiringTodayTvSeries: true),
      const TvSeriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    }
  );

  blocTest<DetailTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesDetailHasData] when data detail tv series is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvSeriesDetail));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const GetTvSeriesDetailEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesDetailHasData(isLoadingTvSeries: true),
      TvSeriesDetailHasData(tvSeries: testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(tId));
    }
  );

  blocTest<DetailTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesDetailHasData] when data recommendations tv series is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvSeriesList));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const GetTvSeriesRecommendationsEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesDetailHasData(isLoadingRecommendations: true),
      TvSeriesDetailHasData(tvSeriesRecommendations: tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    }
  );

  blocTest<DetailTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesDetailHasData, TvSeriesError] when data detail tv series is gotten unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const GetTvSeriesDetailEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      const TvSeriesDetailHasData(isLoadingTvSeries: true),
      const TvSeriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(tId));
    }
  );

  blocTest<DetailTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesDetailHasData] when save watchlist tv series is gotten successfully',
    build: () {
      when(mockSaveWatchlist.execute(testTvSeriesDetail)).thenAnswer((_) async => const Right("Success"));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc
      ..add(AddTvSeriesWatchlistEvent(testTvSeriesDetail))
      ..add(const LoadWatchlistStatusEvent(tId)),
    expect: () => <TvSeriesState>[
      const TvSeriesDetailHasData(isAddedToWatchlist: false, message: "Success"),
      const TvSeriesDetailHasData(isAddedToWatchlist: true, message: "Success"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvSeriesDetail));
      verify(mockGetWatchlistStatus.execute(tId));
    }
  );

   blocTest<PopularTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHasData] when data popular tv series is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      TvSeriesLoading(),
      TvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    }
  );

  blocTest<PopularTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHasData] when data popular tv series is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      TvSeriesLoading(),
      TvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    }
  );

  blocTest<TopRatedTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHasData] when data top rated tv series is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      TvSeriesLoading(),
      TvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    }
  );

  blocTest<WatchlistTvSeriesBloc, TvSeriesState>(
    'Should emit [TvSeriesHasData] when data watchlist tv series is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <TvSeriesState>[
      TvSeriesLoading(),
      TvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    }
  );
}
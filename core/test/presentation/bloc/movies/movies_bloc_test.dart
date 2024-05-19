import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/presentation/bloc/movies/movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/movies/dummy_objects.dart';
import 'movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchlistMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchListStatus,
])
void main() {
  late HomeMoviesBloc homeMoviesBloc;
  late DetailMoviesBloc detailMoviesBloc;
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchlistStatus;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];
  const tId = 1;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    
    homeMoviesBloc = HomeMoviesBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies, 
      getPopularMovies: mockGetPopularMovies, 
      getTopRatedMovies: mockGetTopRatedMovies
    );
    detailMoviesBloc = DetailMoviesBloc(
      getMovieDetail: mockGetMovieDetail, 
      getMovieRecommendations: mockGetMovieRecommendations, 
      saveWatchlist: mockSaveWatchlist, 
      removeWatchlist: mockRemoveWatchlist, 
      getWatchListStatus: mockGetWatchlistStatus
    );
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
  });

  blocTest<HomeMoviesBloc, MoviesState>(
    'Should emit [MoviesHomeHasData] when data now playing is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return homeMoviesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesHomeHasData(isLoadingNowPlayingMovies: true),
      MoviesHomeHasData(nowPlayingMovies: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    }
  );

  blocTest<HomeMoviesBloc, MoviesState>(
    'Should emit [MoviesHomeHasData] when data popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return homeMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesHomeHasData(isLoadingPopularMovies: true),
      MoviesHomeHasData(popularMovies: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );

  blocTest<HomeMoviesBloc, MoviesState>(
    'Should emit [MoviesHomeHasData] when data top rated movies is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return homeMoviesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesHomeHasData(isLoadingTopRatedMovies: true),
      MoviesHomeHasData(topRatedMovies: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    }
  );

  blocTest<HomeMoviesBloc, MoviesState>(
    'Should emit [MoviesHomeHasData, MoviesError] when data now playing is gotten unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return homeMoviesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesHomeHasData(isLoadingNowPlayingMovies: true),
      const MoviesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    }
  );

  blocTest<DetailMoviesBloc, MoviesState>(
    'Should emit [MoviesDetailHasData] when data detail movies is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testMovieDetail));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetailEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesDetailHasData(isLoadingMovie: true),
      const MoviesDetailHasData(movie: testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    }
  );

  blocTest<DetailMoviesBloc, MoviesState>(
    'Should emit [MoviesDetailHasData] when data recommendations movies is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(tMovieList));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationsEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesDetailHasData(isLoadingRecommendations: true),
      MoviesDetailHasData(movieRecommendations: tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    }
  );

  blocTest<DetailMoviesBloc, MoviesState>(
    'Should emit [MoviesDetailHasData, MoviesError] when data detail movies is gotten unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetailEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      const MoviesDetailHasData(isLoadingMovie: true),
      const MoviesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    }
  );

  blocTest<DetailMoviesBloc, MoviesState>(
    'Should emit [MoviesDetailHasData] when save watchlist movies is gotten successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async => const Right("Success"));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      return detailMoviesBloc;
    },
    act: (bloc) => bloc
      ..add(const AddMovieWatchlistEvent(testMovieDetail))
      ..add(const LoadWatchlistStatusEvent(tId)),
    expect: () => <MoviesState>[
      const MoviesDetailHasData(isAddedToWatchlist: false, message: "Success"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(tId));
    }
  );

   blocTest<PopularMoviesBloc, MoviesState>(
    'Should emit [MoviesHasData] when data popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );

  blocTest<PopularMoviesBloc, MoviesState>(
    'Should emit [MoviesHasData] when data popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(GetPopularMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );

  blocTest<TopRatedMoviesBloc, MoviesState>(
    'Should emit [MoviesHasData] when data top rated movies is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    }
  );

  blocTest<WatchlistMoviesBloc, MoviesState>(
    'Should emit [MoviesHasData] when data watchlist movies is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right(tMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    }
  );
}
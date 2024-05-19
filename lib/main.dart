import 'package:about/about_page.dart';
import 'package:core/presentation/bloc/movies/movies_bloc.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:core/utils/utils.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/home_movie_page.dart';
import 'package:core/presentation/pages/movies/now_playing_movies_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:core/presentation/pages/tv_series/airing_today_tv_series.dart';
import 'package:core/presentation/pages/tv_series/home_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_series/watchlist_series_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/bloc/movies/search_bloc.dart';
import 'package:search/bloc/tv_series/search_bloc.dart';
import 'package:search/presentation/pages/movies/search_page.dart';
import 'package:search/presentation/pages/tv_series/search_page.dart';
import 'package:core/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await HttpSSLPinning.init();
  di.init();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // movies
        /* ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingMoviesNotifier>(),
        ), */
        BlocProvider(
          create: (_) => di.locator<HomeMoviesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMoviesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>()
        ),
        // tv series
        /* ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTvSeriesNotifier>(),
        ), */
        BlocProvider(
          create: (_) => di.locator<HomeTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodayTvSeriesBloc>()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // movies
            case HOME_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case NOW_PLAYING_ROUTE:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
            // tv series
            case HOME_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => const HomeTvSeriesPage());
            case POPULAR_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TV_SERIES_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
            case WATCHLIST_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case AIRING_TODAY_ROUTE:
              return MaterialPageRoute(builder: (_) => AiringTodayTvSeriesPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

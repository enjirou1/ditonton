import 'package:ditonton/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  firstAirDate: '2023-01-23',
  name: 'Dirty Linen',
  originCountry: const [
    "PH"
  ],
  originalLanguage: 'tl',
  originalName: 'Dirty Linen',
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  overview: "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  popularity: 2797.914,
  posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
  voteAverage: 5,
  voteCount: 13
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  firstAirDate: 'firstAirDate',
  name: 'name',
  originCountry: const ["1", "2", "3"],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  backdropPath: 'backdropPath',
  genres: const [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  adult: false,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  popularity: 1
);

const testTvSeriesCache = TvSeriesTable(
  id: 557,
  overview: 'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
  name: 'Dirty Linen',
);

final testTvSeriesCacheMap = {
  'id': 557,
  'overview': 'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  'posterPath': '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
  'name': 'Dirty Linen',
};

final testTvSeriesFromCache = TvSeries.watchlist(
  id: 557,
  overview: 'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
  name: 'Dirty Linen',
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'title',
};

import 'dart:convert';

import 'package:ditonton/data/models/tv_series/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
    firstAirDate: "2023-01-23",
    genreIds: [
      9648,
      18
    ],
    id: 202250,
    name: "Dirty Linen",
    originCountry: [
      "PH"
    ],
    originalLanguage: "tl",
    originalName: "Dirty Linen",
    overview: "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
    popularity: 2797.914,
    posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
    voteAverage: 5,
    voteCount: 13
  );

  const tTvSeriesResponseModel = TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/tv_series/airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "first_air_date": '2023-01-23',
            "name": 'Dirty Linen',
            "origin_country": ["PH"],
            "original_language": 'tl',
            "original_name": 'Dirty Linen',
            "backdrop_path": "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
            "genre_ids": [
              9648,
              18
            ],
            "id": 202250,
            "overview": "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
            "popularity": 2797.914,
            "poster_path": "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
            "vote_average": 5,
            "vote_count": 13
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

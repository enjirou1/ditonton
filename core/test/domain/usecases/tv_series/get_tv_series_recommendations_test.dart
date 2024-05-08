import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeriesList = <TvSeries>[];

  test('should get list of tv series recommendations from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendations(tId)).thenAnswer((_) async => Right(tTvSeriesList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeriesList));
  });
}

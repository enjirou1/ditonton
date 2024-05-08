import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRpository;

  setUp(() {
    mockTvSeriesRpository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRpository);
  });

  final tTvSeriesList = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test('should get list of tv series from the repository when execute function is called', () async {
        // arrange
        when(mockTvSeriesRpository.getPopularTvSeries()).thenAnswer((_) async => Right(tTvSeriesList));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvSeriesList));
      });
    });
  });
}

import 'package:dartz/dartz.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import '../../../utils/failure.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}

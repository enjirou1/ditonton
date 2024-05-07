import 'package:dartz/dartz.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import '../../../utils/failure.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}

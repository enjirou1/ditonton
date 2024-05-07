import '../../lib/utils/network_info.dart';
import '../../lib/data/datasources/movie_local_data_source.dart';
import '../../lib/data/datasources/db/database_helper.dart';
import '../../lib/data/datasources/movie_remote_data_source.dart';
import '../../lib/data/datasources/tv_series_local_data_source.dart';
import '../../lib/data/datasources/tv_series_remote_data_source.dart';
import '../../lib/domain/repositories/movie_repository.dart';
import '../../lib/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

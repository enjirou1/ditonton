import '../../../utils/state_enum.dart';
import '../../../domain/entities/tv_series.dart';
import '../../../domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:flutter/foundation.dart';

class AiringTodayTvSeriesNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayTvSeriesNotifier({required this.getAiringTodayTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];
  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesListData) {
        _tvSeriesList = tvSeriesListData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

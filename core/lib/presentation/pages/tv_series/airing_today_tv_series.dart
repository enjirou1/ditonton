import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/presentation/pages/tv_series/home_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv-series';

  @override
  _AiringTodayTvSeriesPageState createState() => _AiringTodayTvSeriesPageState();
}

class _AiringTodayTvSeriesPageState extends State<AiringTodayTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      // Provider.of<AiringTodayTvSeriesNotifier>(context, listen: false).fetchAiringTodayTvSeries()
      context.read<AiringTodayTvSeriesBloc>().add(GetAiringTodayTvSeriesEvent())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        /* child: Consumer<AiringTodayTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeriesList[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.tvSeriesList.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ), */
        child: BlocBuilder<AiringTodayTvSeriesBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is TvSeriesHomeHasData) {
              if (state.isLoadingAiringTodayTvSeries) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return TvSeriesList(state.airingTodayTvSeries);
              }
            } else if (state is TvSeriesEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Text('Failed');
            }
          }
        ),
      ),
    );
  }
}

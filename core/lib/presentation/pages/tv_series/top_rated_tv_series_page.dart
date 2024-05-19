import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      // Provider.of<TopRatedTvSeriesNotifier>(context, listen: false).fetchTopRatedTvSeries()
      context.read<TopRatedTvSeriesBloc>().add(GetTopRatedTvSeriesEvent())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        /* child: Consumer<TopRatedTvSeriesNotifier>(
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
        child: BlocBuilder<TopRatedTvSeriesBloc, TvSeriesState>(
          builder: (context, state) {
            if (state is TvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              ); 
            } else if (state is TvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/utils/utils.dart';
import 'package:core/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv-series';

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      // Provider.of<WatchlistTvSeriesNotifier>(context, listen: false).fetchWatchlistTvSeries()
      context.read<WatchlistTvSeriesBloc>().add(GetWatchlistTvSeriesEvent())
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // Provider.of<WatchlistTvSeriesNotifier>(context, listen: false).fetchWatchlistTvSeries();
    context.read<WatchlistTvSeriesBloc>().add(GetWatchlistTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        /* child: Consumer<WatchlistTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.watchlistTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.watchlistTvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ), */
        child: BlocBuilder<WatchlistTvSeriesBloc, TvSeriesState>(
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

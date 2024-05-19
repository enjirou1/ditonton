import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv_series/tv_series_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/widgets/custom_animated_drawer.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-series';

  const HomeTvSeriesPage({super.key});

  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      /* Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchAiringTodayTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries() */
      context.read<HomeTvSeriesBloc>()
        ..add(GetAiringTodayTvSeriesEvent())
        ..add(GetPopularTvSeriesEvent())
        ..add(GetTopRatedTvSeriesEvent())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomAnimatedDrawer(
        content: Scaffold(
          drawer: const CustomDrawer(routeName: HOME_TV_SERIES_ROUTE),
          appBar: AppBar(
            title: const Text('Tv Series'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubHeading(
                    title: 'Airing Today',
                    onTap: () => Navigator.pushNamed(context, AIRING_TODAY_ROUTE),
                  ),
                  /* Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                    final state = data.airingTodayState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvSeriesList(data.airingTodayTvSeries);
                    } else {
                      return const Text('Failed');
                    }
                  }), */
                  BlocBuilder<HomeTvSeriesBloc, TvSeriesState>(
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
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.pushNamed(context, POPULAR_TV_SERIES_ROUTE),
                  ),
                  /* Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                    final state = data.popularTvSeriesState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvSeriesList(data.popularTvSeries);
                    } else {
                      return const Text('Failed');
                    }
                  }), */
                  BlocBuilder<HomeTvSeriesBloc, TvSeriesState>(
                    builder: (context, state) {
                      if (state is TvSeriesHomeHasData) {
                        if (state.isLoadingPopularTvSeries) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return TvSeriesList(state.popularTvSeries);
                        }
                      } else if (state is TvSeriesEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Text('Failed');
                      }
                    }
                  ),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_SERIES_ROUTE),
                  ),
                  /* Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                    final state = data.topRatedTvSeriesState;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return TvSeriesList(data.topRatedTvSeries);
                    } else {
                      return const Text('Failed');
                    }
                  }), */
                  BlocBuilder<HomeTvSeriesBloc, TvSeriesState>(
                    builder: (context, state) {
                      if (state is TvSeriesHomeHasData) {
                        if (state.isLoadingTopRatedTvSeries) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return TvSeriesList(state.topRatedTvSeries);
                        }
                      } else if (state is TvSeriesEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Text('Failed');
                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList(this.tvSeriesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_SERIES_DETAIL_ROUTE,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}

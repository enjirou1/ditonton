import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv_series/airing_today_tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/search_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_animated_drawer.dart';
import 'package:ditonton/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchAiringTodayTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomAnimatedDrawer(
        content: Scaffold(
          drawer: const CustomDrawer(routeName: HomeTvSeriesPage.ROUTE_NAME),
          appBar: AppBar(
            title: const Text('Tv Series'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchTvSeriesPage.ROUTE_NAME);
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
                    onTap: () => Navigator.pushNamed(context, AiringTodayTvSeriesPage.ROUTE_NAME),
                  ),
                  Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
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
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () => Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
                  ),
                  Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
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
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () => Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
                  ),
                  Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
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
                  }),
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
                  TvSeriesDetailPage.ROUTE_NAME,
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

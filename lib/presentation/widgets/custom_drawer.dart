import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_series_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String routeName;

  const CustomDrawer({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
            accountName: Text('Andy'),
            accountEmail: Text('andy.halim2704.com'),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 110, 241)
            ),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              if (routeName == HomeMoviePage.ROUTE_NAME) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Movies Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: () {
              if (routeName == HomeTvSeriesPage.ROUTE_NAME) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Tv Series Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
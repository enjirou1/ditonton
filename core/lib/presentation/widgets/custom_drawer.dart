import 'package:core/utils/routes.dart';
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
              if (routeName == HOME_MOVIES_ROUTE) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, HOME_MOVIES_ROUTE);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Movies Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WATCHLIST_MOVIES_ROUTE);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: () {
              if (routeName == HOME_TV_SERIES_ROUTE) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pushNamed(context, HOME_TV_SERIES_ROUTE);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Tv Series Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WATCHLIST_TV_SERIES_ROUTE);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ABOUT_ROUTE);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
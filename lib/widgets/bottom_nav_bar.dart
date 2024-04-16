import 'package:flutter/material.dart';
import 'package:movies_app_route/screens/browse_screen.dart';
import 'package:movies_app_route/screens/home_screen.dart';
import 'package:movies_app_route/screens/search_screen.dart';
import 'package:movies_app_route/screens/watch_list_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            width: double.infinity,
            color: Colors.black,
            height: 70,
            child: const TabBar(tabs: [
              Tab(icon: Icon(Icons.home),text: "HOME",),
              Tab(icon: Icon(Icons.search),text: "SEARCH",),
              Tab(icon: Icon(Icons.video_library),text: "BROWSE",),
              Tab(icon: Icon(Icons.playlist_play_outlined),text: "WATCHLIST",),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.amber,
            unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: TabBarView(children: [
            const HomeScreen(),
            const SearchScreen(),
            BrowseCategoriesScreen(),
            const WatchListScreen()
          ]),
        ));
  }
}

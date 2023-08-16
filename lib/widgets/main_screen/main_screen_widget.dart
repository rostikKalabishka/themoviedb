import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/widgets/main_screen/series_list/series_list_widget.dart';

import '../../Theme/app_bar_style.dart';
import '../../Theme/thema.dart';
import 'movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Text('1 news'),
          MovieListWidget(),
          SeriesListWidget(),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TMDB',
          style: AppColors.textAppBar,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: Color.fromRGBO(3, 37, 65, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV series',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}

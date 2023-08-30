import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/main_screen/movie_list/movie_list_model.dart';

import 'package:themoviedb/ui/widgets/main_screen/series_list/series_list_widget.dart';

import '../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../Theme/app_bar_style.dart';

import 'home_page/home_page_widget.dart';
import 'movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    movieListModel.setupLocale(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const HomePageWidget(),
          NotifierProvider(
            model: movieListModel,
            child: const MovieListWidget(),
          ),
          SeriesListWidget(),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TMDB',
          style: AppColors.textAppBar,
        ),
        //test
        leading: IconButton(
          icon: const Icon(
            Icons.logout_sharp,
            color: Color.fromARGB(255, 14, 117, 201),
            size: 30,
          ),
          onPressed: () {
            SessionDataProvider().setSessionId(null);
          },
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

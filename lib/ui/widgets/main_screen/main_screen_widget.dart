import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';

import 'package:themoviedb/ui/widgets/main_screen/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_list_model.dart';

import 'package:themoviedb/ui/widgets/main_screen/series_list/series_list_widget.dart';

import '../../Theme/app_bar_style.dart';

import '../../routes/routes.dart';

import 'account/account_model.dart';
import 'home_page/home_page_widget.dart';
import 'home_page/home_page_widget_model.dart';
import 'movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final homePageWidgetModel = HomePageWidgetModel();
  final movieListModel = MovieListModel();
  final seriesListModel = SeriesListModel();
  final accountModel = AccountModel();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    movieListModel.setupLocale(context);
    seriesListModel.setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedTab,
          children: [
            NotifierProvider(
                create: () => homePageWidgetModel,
                child: const HomePageWidget()),
            NotifierProvider(
              create: () => movieListModel,
              isManagingModel: false,
              child: const MovieListWidget(),
            ),
            NotifierProvider(
                create: () => seriesListModel,
                isManagingModel: false,
                child: const SeriesListWidget()),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TMDB',
          style: AppColors.textAppBar,
        ),
        //test
        actions: [
          IconButton(
              icon: const Icon(
                Icons.people,
                color: Color.fromARGB(255, 14, 117, 201),
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(MainNavigationRouteName.account);
              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
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

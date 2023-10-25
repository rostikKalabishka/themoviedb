import 'package:flutter/material.dart';
import '../../../domain/factories/screen_factory.dart';
import '../../Theme/app_bar_style.dart';
import '../../routes/routes.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedTab,
          children: [
            _screenFactory.makeHomePage(),
            _screenFactory.makeMovieList(),
            _screenFactory.makeSeriesList()
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TMDB',
          style: AppColors.textAppBar,
        ),
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

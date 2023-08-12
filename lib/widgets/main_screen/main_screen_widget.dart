import 'package:flutter/material.dart';

import '../../Theme/app_bar_style.dart';
import '../../Theme/thema.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  static const List<Widget> _widgetOptions = [
    Text('1 news'),
    Text('2 films'),
    Text('3 series')
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedTab],
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

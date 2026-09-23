import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/favorite.dart';
import '../screens/history.dart';
import '../screens/profile.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State createState() => _NavigationPageState();
}

class _NavigationPageState extends State {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const FavoritePage(),
      const HistoryPage(),
      ProfilePage(onHomeTap: () => _onTabTapped(0)),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed, // Wajib untuk 4 tab
        selectedItemColor: const Color.fromARGB(255, 13, 105, 225),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Countries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
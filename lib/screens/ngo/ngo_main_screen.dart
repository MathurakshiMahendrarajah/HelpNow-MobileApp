import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo/profile_screen.dart';
import 'home_screen.dart';

class NGOMainScreen extends StatefulWidget {
  const NGOMainScreen({super.key});

  @override
  State<NGOMainScreen> createState() => _NGOMainScreenState();
}

class _NGOMainScreenState extends State<NGOMainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

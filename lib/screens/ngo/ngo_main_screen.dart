import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo/case_dashboard_screen.dart';
import 'package:helpnow_mobileapp/screens/ngo/volunteer_dashboard_screen.dart';
import 'package:helpnow_mobileapp/screens/ngo/profile_screen.dart';

class NGOMainScreen extends StatefulWidget {
  @override
  State<NGOMainScreen> createState() => _NGOMainScreenState();
}

class _NGOMainScreenState extends State<NGOMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CaseDashboardScreen(),
    VolunteerDashboardScreen(),
    ProfileScreen(),
  ];

  static const primaryRed = Color(0xFFEC1337);
  static const backgroundPink = Color(0xFFFCF8F9);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primaryRed,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Volunteers',
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

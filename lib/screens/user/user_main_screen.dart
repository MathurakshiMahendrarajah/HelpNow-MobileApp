import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'report_tab.dart';
import 'track_tab.dart';
import 'profile_tab.dart';

class UserMainScreen extends StatefulWidget {
  final int selectedIndex;
  final String? caseId;
  final bool isMember;
  const UserMainScreen({
    super.key,
    this.selectedIndex = 0,
    this.caseId,
    this.isMember = false,
  });

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  late int _selectedIndex;

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens {
    return [
      UserHomeScreen(
        isMember: widget.isMember,
        onNavigateTab: _changeTab, // Pass callback here
      ),
      const ReportTab(),
      const TrackTab(),
      ProfileTab(isMember: widget.isMember),
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFFF5722),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

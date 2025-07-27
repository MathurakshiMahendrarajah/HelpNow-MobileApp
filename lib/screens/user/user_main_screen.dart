import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'report_tab.dart';
import 'track_tab.dart'; 
import 'profile_tab.dart';
import 'package:amplify_flutter/amplify_flutter.dart'; // import this

class UserMainScreen extends StatefulWidget {
  final int selectedIndex;
  final String? caseId;
  const UserMainScreen({super.key, this.selectedIndex = 0, this.caseId});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  late int _selectedIndex;
  bool _isMember = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _checkUserSignedIn();
  }

  Future<void> _checkUserSignedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      setState(() {
        _isMember = session.isSignedIn;
      });
    } catch (e) {
      // Optional: handle error
      setState(() {
        _isMember = false;
      });
    }
  }

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens {
    return [
      UserHomeScreen(isMember: _isMember, onNavigateTab: _changeTab),
      const ReportTab(),
      const TrackTab(),
      ProfileTab(),
    ];
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
        backgroundColor: Colors.white,
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

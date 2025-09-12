import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'report_tab.dart';
import 'track_tab.dart';
import 'profile_tab.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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
      setState(() => _isMember = false);
    }
  }

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens {
    return [
      UserHomeScreen(
        isMember: _isMember,
        userName: "User",
        onNavigateTab: _changeTab,
      ),
      const ReportTab(),
      const TrackTab(),
      ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color(0xFFEC1337);
    const Color unselectedColor = Color.fromARGB(255, 128, 48, 48);
    const backgroundPink = Color(0xFFFCF8F9);

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: backgroundPink,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent, // no background highlight
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((
            states,
          ) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(color: selectedColor); // removed const
            }
            return TextStyle(color: unselectedColor); // removed const
          }),
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: selectedColor); // removed const
            }
            return IconThemeData(color: unselectedColor); // removed const
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
              icon: Icon(Icons.add_box_outlined),
              label: "Report",
            ),
            NavigationDestination(
              icon: Icon(Icons.track_changes),
              label: "Track",
            ),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

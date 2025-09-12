import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_dashboard.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_profile.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_login_screen.dart'; // Import the Login Screen

class VolunteerMainScreen extends StatefulWidget {
  @override
  _VolunteerMainScreenState createState() => _VolunteerMainScreenState();
}

class _VolunteerMainScreenState extends State<VolunteerMainScreen> {
  int _currentIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [VolunteerDashboard(), VolunteerProfile()];

  // Method to handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Method for sign out with confirmation dialog
  void _signOut() {
    // Show the confirmation dialog before signing out
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            // No button: Close the dialog
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("No"),
            ),
            // Yes button: Proceed with sign-out
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VolunteerLoginScreen(),
                  ), // Go to login screen
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String userName =
        "John Doe"; // Replace with actual user name or get from data

    return Scaffold(
      // Custom AppBar with more stylish design
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back arrow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEC1337),
                  Color(0xFF9A4C59),
                ], // Red to Maroon gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Profile picture in AppBar
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/profile_picture.png',
                    ), // Replace with dynamic image if available
                    radius: 30, // Larger profile image
                  ),
                  SizedBox(width: 16),
                  // Greeting text with dynamic user name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, $userName!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _currentIndex == 1
                            ? 'Welcome to Profile!'
                            : 'Welcome back to the Volunteer Dashboard!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Sign-out button at the top right
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _signOut, // Handle sign-out logic
                  ),
                ],
              ),
            ),
          ),
          elevation: 10,
        ),
      ),
      body: Column(
        children: [
          // Display the selected page
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFEC1337),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

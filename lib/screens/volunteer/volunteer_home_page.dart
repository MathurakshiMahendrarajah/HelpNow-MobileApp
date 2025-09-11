import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class VolunteerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Volunteer!'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Navigate to login screen to sign out
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VolunteerLoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TypewriterAnimatedTextKit(
              text: ['Welcome to the Volunteer App!'],
              textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 100),
            ),
            SizedBox(height: 20),
            Text(
              'You have 3 new cases near you! Check them out:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            _buildCaseCard(
              'Flood Relief',
              'Help families affected by recent floods.',
            ),
            _buildCaseCard('Shelter Support', 'Assist at a local shelter.'),
            _buildCaseCard(
              'Community Cleanup',
              'Join us in cleaning up the local park.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseCard(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to case details page
        },
      ),
    );
  }
}

class VolunteerLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Volunteer Login')),
      body: Center(child: Text('Login Screen')),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo_login_screen.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/help.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay to increase readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'HelpNow',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"Be the reason someone smiles today"',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const Spacer(),
                  buildFrostedCard(
                    context,
                    icon: Icons.business,
                    title: 'NGO Login',
                    subtitle: 'Access NGO tools and manage your outreach.',
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NGOSignInScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  buildFrostedCard(
                    context,
                    icon: Icons.volunteer_activism,
                    title: 'Volunteer Login',
                    subtitle: 'Join as a helper and make a difference.',
                    color: Colors.greenAccent.shade700,
                    onPressed: () {
                      // Navigate to volunteer login
                    },
                  ),
                  const SizedBox(height: 20),
                  buildFrostedCard(
                    context,
                    icon: Icons.remove_red_eye,
                    title: 'Continue as Guest',
                    subtitle: 'Explore HelpNow without signing in.',
                    color: Colors.orangeAccent,
                    onPressed: () {
                      // Navigate to guest dashboard
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFrostedCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      required VoidCallback onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style:
                            TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Go'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

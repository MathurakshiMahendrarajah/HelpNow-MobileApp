import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/about_screen.dart';
import 'package:helpnow_mobileapp/screens/user/contactUs_screen.dart';
import 'package:helpnow_mobileapp/screens/user/privacy_policy_screen.dart';
import 'package:helpnow_mobileapp/screens/user/setting_Screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart'; // Replace with actual login screen path

class ProfileTab extends StatelessWidget {
  final bool isMember;

  const ProfileTab({super.key, required this.isMember});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFFFFCCBC), // App bar remains the same
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: isMember
                        ? const NetworkImage('https://via.placeholder.com/150')
                        : null,
                    child: !isMember
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isMember ? 'John Doe' : 'Guest User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isMember)
                    const Text(
                      'johndoe@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Common Options in Cards
            _buildCardTile(
              context,
              icon: Icons.info,
              text: 'About Us',
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                );
              },
            ),
            _buildCardTile(
              context,
              icon: Icons.contact_mail,
              text: 'Contact Us',
              onTap: () {
                // Navigate to Contact Us screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
              },
            ),
            _buildCardTile(
              context,
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onTap: () {
                // Navigate to Privacy Policy screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            // Member only: Settings
            if (isMember)
              _buildCardTile(
                context,
                icon: Icons.settings,
                text: 'Settings',
                onTap: () {
                  // Navigate to Settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),

            const Divider(),

            // Guest only: Create Account
            if (!isMember)
              _buildCardTile(
                context,
                icon: Icons.person_add,
                text: 'Create Account',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),

            // Logout (common)
            if (isMember)
              _buildCardTile(
                context,
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      UserMainScreen(),
                                ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // Reusable card-style list tile
  Widget _buildCardTile(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrangeAccent),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:helpnow_mobileapp/screens/user/about_screen.dart';
import 'package:helpnow_mobileapp/screens/user/contactUs_screen.dart';
import 'package:helpnow_mobileapp/screens/user/privacy_policy_screen.dart';
import 'package:helpnow_mobileapp/screens/user/setting_Screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';
import 'package:helpnow_mobileapp/screens/welcome_screen.dart';
import 'package:helpnow_mobileapp/services/amplify_service.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final AmplifyService _amplifyService = AmplifyService();
  bool isMember = false;
  String? email;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    bool signedIn = await _amplifyService.isSignedIn();

    if (signedIn) {
      try {
        final user = await Amplify.Auth.getCurrentUser();
        final attributes = await Amplify.Auth.fetchUserAttributes();
        final emailAttr = attributes.firstWhere(
          (attr) => attr.userAttributeKey == AuthUserAttributeKey.email,
          orElse: () => const AuthUserAttribute(
            userAttributeKey: AuthUserAttributeKey.email,
            value: 'No Email',
          ),
        );

        setState(() {
          isMember = true;
          email = emailAttr.value;
        });
      } catch (e) {
        setState(() {
          isMember = true;
          email = 'Unknown';
        });
      }
    } else {
      setState(() {
        isMember = false;
        email = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFFFFCCBC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
                  if (isMember && email != null)
                    Text(
                      email!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildCardTile(
              context,
              icon: Icons.info,
              text: 'About Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsScreen()),
              ),
            ),
            _buildCardTile(
              context,
              icon: Icons.contact_mail,
              text: 'Contact Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactUsScreen()),
              ),
            ),
            _buildCardTile(
              context,
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              ),
            ),

            if (isMember)
              _buildCardTile(
                context,
                icon: Icons.settings,
                text: 'Settings',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),

            const Divider(),

            if (!isMember)
              _buildCardTile(
                context,
                icon: Icons.person_add,
                text: 'Create Account',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
              ),

            if (isMember)
              _buildCardTile(
                context,
                icon: Icons.logout,
                text: 'Logout',
                onTap: () async {
                  try {
                    await _amplifyService.signOut();

                    // After successful sign out, navigate to WelcomeScreen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false, // This clears the backstack
                    );
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: $e')),
                      );
                    }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

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

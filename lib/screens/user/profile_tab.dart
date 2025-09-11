import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/about_screen.dart';
import 'package:helpnow_mobileapp/screens/user/contactUs_screen.dart';
import 'package:helpnow_mobileapp/screens/user/privacy_policy_screen.dart';
import 'package:helpnow_mobileapp/screens/user/setting_Screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';
import 'package:helpnow_mobileapp/screens/welcome_screen.dart';
import 'package:helpnow_mobileapp/services/amplify_service.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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
      backgroundColor: const Color(0xFFfcf8f9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF1b0d10),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF1b0d10),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Image & Info
          Center(
            child: Column(
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: isMember
                        ? const DecorationImage(
                            image: AssetImage('assets/profile_sample.jpg'),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !isMember
                      ? const Icon(Icons.person, size: 64, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  isMember ? 'Sophia Carter' : 'Guest User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1b0d10),
                  ),
                ),
                Text(
                  isMember ? 'Volunteer' : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9a4c59),
                  ),
                ),
                Text(
                  isMember ? 'Joined 2022' : '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Stats Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('120', 'Points'),
              _buildStatCard('5', 'Badges'),
              _buildStatCard('3', 'Certificates'),
            ],
          ),
          const SizedBox(height: 20),
          // Account Section
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1b0d10),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              children: [
                _buildAccountTile('Edit Profile', Icons.edit, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                  );
                }),
                const Divider(height: 1),
                _buildAccountTile('Preferences', Icons.settings, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                }),
                const Divider(height: 1),
                _buildAccountTile('Logout', Icons.logout, () async {
                  if (!isMember) return;
                  try {
                    await _amplifyService.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false,
                    );
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: $e')),
                      );
                    }
                  }
                }, iconColor: const Color(0xFF8c1c34)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8c1c34),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTile(
    String text,
    IconData icon,
    VoidCallback onTap, {
    Color iconColor = Colors.deepOrangeAccent,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

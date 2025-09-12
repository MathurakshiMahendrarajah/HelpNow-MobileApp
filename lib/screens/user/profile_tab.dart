import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/preferencesScreen.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';
import 'package:image_picker/image_picker.dart';
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
  String userName = 'Dilini';
  File? profileImage;

  final Color backgroundPink = const Color(0xFFFCF8F9);
  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    bool signedIn = await _amplifyService.isSignedIn();
    if (!signedIn) {
      _redirectToLogin();
      return;
    }

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
  }

  void _redirectToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isMember) {
      // Show loading while checking sign-in status
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: backgroundPink,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF1b0d10),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Image & Name
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : const NetworkImage(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuDnRoeqsLq2OubRusXNEJtkYCx7RJYeUGw2kjUltUDNzmZGJpszvvtMlszhxxsJ_JQtOUDxWog7vrmIE4hNCADovfjNrj50jqUIne7hGzYv-YR2f4HDZJr5a5o9C3pvioNMHBmduQXxvaz-kzLWpMeYN8_FE3YFIhtT18yzIL277PvTTJ8_mxbh8PPQlEjshk9is2jHUCc6YwveNXKKrAoOIrd7fCuX-PcnC9k0AwM_z6vMSvAlvL8KoWVf4Bx6eYB_XpDiKsNW",
                          ),
                    onBackgroundImageError: (_, __) {
                      // fallback to asset if network image fails
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1b0d10),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Stats (Points & Badges)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('120', 'Points'),
              _buildStatCard('5', 'Badges'),
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
                _buildAccountTile('Edit Profile', Icons.edit, () async {
                  final newName = await _showEditProfileDialog();
                  if (newName != null) setState(() => userName = newName);
                }),
                const Divider(height: 1),
                _buildAccountTile('Preferences', Icons.settings, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PreferencesScreen(),
                    ),
                  );
                }),
                const Divider(height: 1),
                _buildAccountTile('Logout', Icons.logout, () async {
                  try {
                    await _amplifyService.signOut();
                    if (!mounted) return;
                    _redirectToLogin(); // Go to LoginScreen after logout
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed: $e')),
                      );
                    }
                  }
                }, iconColor: const Color(0xFFEC1337)),
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
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
    Color iconColor = const Color(0xFFEC1337),
  }) {
    return Container(
      color: Colors.white, // Set background color to white
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Future<String?> _showEditProfileDialog() async {
    final controller = TextEditingController(text: userName);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : const AssetImage('assets/profile_sample.jpg')
                          as ImageProvider,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'settings_screen.dart';
import 'ngo_login_screen.dart'; // Update to your login screen path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Helping Hands NGO"),
            accountEmail: Text("ngo@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.volunteer_activism, color: Colors.deepPurple),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),
          buildTile(
              icon: Icons.settings,
              title: "Settings",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()))),
          buildTile(
              icon: Icons.info,
              title: "About",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()))),
          buildTile(
              icon: Icons.contact_mail,
              title: "Contact",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ContactScreen()))),
          const Divider(),
          buildTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                // You can add confirmation dialog here
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => NGOSignInScreen()),
                  (route) => false,
                );
              }),
        ],
      ),
    );
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

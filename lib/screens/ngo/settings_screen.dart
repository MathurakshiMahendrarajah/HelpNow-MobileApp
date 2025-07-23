import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo/change_password_screen.dart';
import 'package:helpnow_mobileapp/screens/ngo/language_selection_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          sectionTitle("Account"),
          buildSettingsTile(
            icon: Icons.lock,
            title: "Change Password",
            subtitle: "Update your login password",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
            ),
          ),
          buildSettingsTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "Select app language",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
            ),
          ),

          const SizedBox(height: 20),
          sectionTitle("Preferences"),
          SwitchListTile(
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() => notificationsEnabled = value);
            },
            secondary: const Icon(Icons.notifications),
            title: const Text("Enable Notifications"),
          ),
          SwitchListTile(
            value: isDarkMode,
            onChanged: (value) {
              setState(() => isDarkMode = value);
              // You can trigger theme change here
            },
            secondary: const Icon(Icons.brightness_6),
            title: const Text("Dark Mode"),
          ),

          const SizedBox(height: 20),
          sectionTitle("App Info"),
          buildSettingsTile(
            icon: Icons.info_outline,
            title: "About",
            onTap: () {
              // Navigate to About screen
            },
          ),
          buildSettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: () {
              // Navigate to privacy screen
            },
          ),

          const SizedBox(height: 40),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Handle logout confirmation and redirect
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content:
                        const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("Cancel")),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (_) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text("Logout"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool pushNotifications = true;
  bool emailAlerts = false;
  bool dataSharing = true;
  bool locationServices = true;
  String selectedLanguage = 'English';

  final Color primaryRed = const Color(0xFFEC1337);
  final Color textPrimary = const Color(0xFF1b0d10);
  final Color textSecondary = const Color(0xFF9a4c59);
  final Color secondaryBg = const Color(0xFFFCF8F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBg,
      appBar: AppBar(
        backgroundColor: secondaryBg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Preferences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1b0d10),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1b0d10)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Notifications',
            children: [
              _buildToggleTile(
                title: 'Push Notifications',
                subtitle: 'For new requests and updates.',
                value: pushNotifications,
                onChanged: (v) => setState(() => pushNotifications = v),
              ),
              _buildToggleTile(
                title: 'Email Alerts',
                subtitle: 'For account activity.',
                value: emailAlerts,
                onChanged: (v) => setState(() => emailAlerts = v),
              ),
            ],
          ),
          _buildSection(
            title: 'Language',
            children: [
              ListTile(
                title: const Text(
                  'Select Language',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedLanguage,
                      style: TextStyle(color: textSecondary),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                onTap: () async {
                  final lang = await _showLanguageDialog();
                  if (lang != null) setState(() => selectedLanguage = lang);
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Privacy',
            children: [
              _buildToggleTile(
                title: 'Data Sharing',
                subtitle: 'Control how your data is used.',
                value: dataSharing,
                onChanged: (v) => setState(() => dataSharing = v),
              ),
              _buildToggleTile(
                title: 'Location Services',
                subtitle: 'For personalized services.',
                value: locationServices,
                onChanged: (v) => setState(() => locationServices = v),
              ),
            ],
          ),
          _buildSection(
            title: 'Account',
            children: [
              ListTile(
                title: const Text(
                  'Change Password',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // implement change password
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // implement delete account
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Legal',
            children: [
              ListTile(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.open_in_new, color: Colors.grey),
                onTap: () {
                  // open privacy policy
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'Terms of Service',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.open_in_new, color: Colors.grey),
                onTap: () {
                  // open terms of service
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildToggleTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Switch(
        value: value,
        activeColor: primaryRed,
        onChanged: onChanged,
      ),
    );
  }

  Future<String?> _showLanguageDialog() async {
    final languages = ['English', 'Spanish', 'French', 'German'];
    return showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: languages
            .map(
              (lang) => SimpleDialogOption(
                child: Text(lang),
                onPressed: () => Navigator.pop(context, lang),
              ),
            )
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English';

  final List<String> languages = [
    'English',
    'සිංහල (Sinhala)',
    'தமிழ் (Tamil)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final lang = languages[index];
          return ListTile(
            title: Text(lang),
            trailing: selectedLanguage == lang
                ? const Icon(Icons.check_circle, color: Colors.deepPurple)
                : null,
            onTap: () {
              setState(() {
                selectedLanguage = lang;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Language changed to $lang"),
                ),
              );

              // Handle locale update or save language setting here
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionText(
              "Your privacy is important to us. This Privacy Policy explains how HelpNow collects, uses, protects, and shares your information when you use our services.",
            ),

            sectionTitle('1. Information We Collect'),
            sectionText(
              "- Personal details (name, email, phone number) when you register or contact us.\n"
              "- Location information, if you enable it, to help direct aid efficiently.\n"
              "- Reported case details and user interactions within the app.\n"
              "- Device information such as IP address, device ID, and operating system.",
            ),

            sectionTitle('2. How We Use Your Information'),
            sectionText(
              "- To connect people in need with the appropriate NGO or volunteer.\n"
              "- To improve our app experience, functionality, and support.\n"
              "- To communicate updates, responses to reports, or partnership inquiries.",
            ),

            sectionTitle('3. Sharing Your Information'),
            sectionText(
              "- We only share necessary case details with verified NGOs and partners.\n"
              "- We do **not** sell or rent your personal data to third parties.\n"
              "- With your consent, we may share anonymized data for research or impact analysis.",
            ),

            sectionTitle('4. Data Security'),
            sectionText(
              "We implement industry-standard security measures to protect your data from unauthorized access. All communication is encrypted and securely stored.",
            ),

            sectionTitle('5. Your Rights'),
            sectionText(
              "- You can request access to or deletion of your personal data at any time.\n"
              "- You can opt out of communications or location access through settings.",
            ),

            sectionTitle('6. Children’s Privacy'),
            sectionText(
              "HelpNow is not intended for use by individuals under the age of 13 without parental consent.",
            ),

            sectionTitle('7. Updates to This Policy'),
            sectionText(
              "We may update this policy to reflect changes in legal or operational practices. You’ll be notified of major changes via the app.",
            ),

            sectionTitle('8. Contact Us'),
            sectionText(
              "If you have questions about this Privacy Policy, contact us at:\n\n"
              "📧 contact@helpnow.org\n"
              "📍 123 Hope Street, Compassion City",
            ),
          ],
        ),
      ),
    );
  }
}

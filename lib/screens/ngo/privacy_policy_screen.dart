import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const primaryRed = Color(0xFFEC1337);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: primaryRed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: const Text(
          "Your privacy is important to us. We do not share your personal data "
          "without your consent. All volunteer and case information is securely "
          "stored and managed according to our privacy policies.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

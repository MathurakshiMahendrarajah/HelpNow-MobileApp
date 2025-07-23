import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About NGO"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Helping Hands is a non-profit organization dedicated to disaster relief, food distribution, and community support.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

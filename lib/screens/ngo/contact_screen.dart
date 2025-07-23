import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("+94 77 123 4567"),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("ngo@example.com"),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("123 NGO Street, Colombo, Sri Lanka"),
          ),
        ],
      ),
    );
  }
}

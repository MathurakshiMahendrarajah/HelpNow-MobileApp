import 'package:flutter/material.dart';

class VolunteerProfile extends StatefulWidget {
  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // You can load profile data here
    _nameController.text = "John Doe"; // Example data
    _emailController.text = "john.doe@example.com"; // Example data
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          _buildProfileField('Full Name', _nameController),
          _buildProfileField('Email Address', _emailController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save profile changes logic
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_dashboard_screen.dart'; // Make sure to create this screen
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_dashboard_screen.dart'; // Update the correct screen as needed

class VolunteerLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.volunteer_activism,
                  size: 60,
                  color: Colors.greenAccent,
                ),
                const SizedBox(height: 10),
                Text(
                  'Volunteer Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Making a difference starts with you',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 30),

                // Login Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        buildInputField(
                          controller: emailController,
                          label: 'Email or Volunteer ID',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 16),
                        buildInputField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VolunteerDashboard(),
                              ), // Navigate to Volunteer Dashboard
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            minimumSize: Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}

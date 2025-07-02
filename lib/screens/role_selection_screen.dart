import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo/ngo_login_screen.dart';
import 'package:helpnow_mobileapp/screens/routes.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        backgroundColor: Color(0xFFC8E6C9),
        // Color(0xFF2E7D32) for menu bar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login As',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // NGO Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.business),
              label: const Text('NGO'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NGOSignInScreen()),
                ); // define this route
              },
            ),
            const SizedBox(height: 20),

            // Volunteer Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.volunteer_activism),
              label: const Text('Volunteer'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => NGOSignInScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

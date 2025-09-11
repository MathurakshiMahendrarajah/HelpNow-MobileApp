import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:helpnow_mobileapp/screens/ngo/ngo_login_screen.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_login_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();

      if (user != null) {
        // 🔹 You can check Cognito groups or user attributes to know the role
        final attributes = await Amplify.Auth.fetchUserAttributes();

        String? role;
        for (var attr in attributes) {
          if (attr.userAttributeKey.key == 'custom:role') {
            role = attr.value; // e.g., "ngo", "volunteer", "public"
          }
        }

        Widget nextScreen;

        if (role == 'ngo') {
          nextScreen = NGOSignInScreen();
        } else if (role == 'volunteer') {
          nextScreen = VolunteerLoginScreen();
        } else {
          nextScreen = LoginScreen(); // fallback default
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextScreen),
        );
      }
    } on AuthException catch (e) {
      safePrint('No user signed in: ${e.message}');
      // Stay on role selection screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
        backgroundColor: Color(0xFFC8E6C9),
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
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VolunteerLoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

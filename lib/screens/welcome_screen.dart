import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:helpnow_mobileapp/screens/role_selection_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';
import 'package:helpnow_mobileapp/screens/ngo/ngo_login_screen.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();

      if (user != null) {
        // Fetch role from Cognito attributes (assuming custom:role is set)
        final attributes = await Amplify.Auth.fetchUserAttributes();

        String? role;
        for (var attr in attributes) {
          if (attr.userAttributeKey.key == 'custom:role') {
            role = attr.value; // "ngo", "volunteer", "public"
          }
        }

        Widget nextScreen;

        if (role == 'ngo') {
          nextScreen = NGOSignInScreen();
        } else if (role == 'volunteer') {
          nextScreen = VolunteerLoginScreen();
        } else {
          nextScreen = const UserMainScreen(selectedIndex: 0);
        }

        // Skip welcome screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextScreen),
        );
      }
    } on AuthException catch (e) {
      safePrint("No signed-in user: ${e.message}");
      // stay on welcome screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/help.jpg', fit: BoxFit.cover),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to HelpNow',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '"Be the reason someone smiles today"',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const Spacer(),

                  // Combined "Get Help" Button
                  buildFrostedCard(
                    context,
                    icon: Icons.volunteer_activism,
                    title: 'Get Help',
                    subtitle: 'Report a case or track your request.',
                    color: const Color(0xFFFF7043),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const UserMainScreen(selectedIndex: 0),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Login as NGO/Volunteer Button
                  buildFrostedCard(
                    context,
                    icon: Icons.login,
                    title: 'Login as NGO/Volunteer',
                    subtitle: 'Access dashboard and manage help requests.',
                    color: const Color(0xFF2E7D32),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RoleSelectionScreen(),
                        ),
                      );
                    },
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFrostedCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Go',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

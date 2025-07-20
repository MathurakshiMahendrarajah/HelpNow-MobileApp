import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/routes.dart';
import 'package:helpnow_mobileapp/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
 
    // Animation setup
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Navigate after 4 seconds ONLY if the widget is still mounted
  Future.delayed(const Duration(seconds: 4), () {
    if (mounted) {
      Navigator.pushReplacementNamed(context, RouteConfig.welcome);
    }
  });
    // Check Amplify Auth status before navigating
  _checkAuthStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

Future<void> _checkAuthStatus() async {
  try {
    final session = await Amplify.Auth.fetchAuthSession();
    safePrint('🔒 User is signed in: ${session.isSignedIn}');
  } catch (e) {
    safePrint('❌ Error fetching auth session: $e');
  }

  // Proceed to next screen after 4 seconds
  Future.delayed(const Duration(seconds: 4), () {
    Navigator.pushReplacementNamed(context, RouteConfig.welcome);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1), // Soft pastel green-blue
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or animated icon
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB2DFDB), // Soft mint
                ),
                child: Icon(
                  Icons.volunteer_activism,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'HelpNow',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF004D40)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/confirmsignup_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';
import 'package:helpnow_mobileapp/services/amplify_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final AmplifyService _amplifyService = AmplifyService();

  bool _isLoading = false;
  String? _authError;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const primaryRed = Color(0xFFD32F2F);
  static const secondaryRed = Color(0xFFB71C1C);
  static const backgroundLight = Color(0xFFFFF5F5);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _authError = null;
    });

    try {
      if (isLogin) {
        final result = await _amplifyService.signIn(
          username: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );

        if (result != 'SUCCESS') {
          setState(() => _authError = result);
          return;
        }
      } else {
        final result = await _amplifyService.signUp(
          username: _usernameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );

        if (result != 'SUCCESS' && result != 'CONFIRMATION_REQUIRED') {
          setState(() => _authError = result);
          return;
        }

        if (result == 'CONFIRMATION_REQUIRED') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ConfirmSignUpScreen(username: _usernameCtrl.text.trim()),
            ),
          );
          return;
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => UserMainScreen()),
      );
    } catch (e) {
      setState(() => _authError = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Hero(
                    tag: 'user_logo',
                    child: Icon(Icons.person_pin, size: 90, color: primaryRed),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isLogin ? "User Login" : "Create Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: secondaryRed,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isLogin
                        ? "Welcome back to HelpNow"
                        : "Join the HelpNow community",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 12,
                      color: Colors.white.withOpacity(0.95),
                      shadowColor: primaryRed.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              if (!isLogin)
                                buildInputField(
                                  controller: _usernameCtrl,
                                  label: 'Username',
                                  icon: Icons.person,
                                ),
                              const SizedBox(height: 16),
                              buildInputField(
                                controller: _emailCtrl,
                                label: 'Email',
                                icon: Icons.email,
                              ),
                              const SizedBox(height: 16),
                              buildInputField(
                                controller: _passwordCtrl,
                                label: 'Password',
                                icon: Icons.lock,
                                obscureText: true,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    activeColor: primaryRed,
                                    onChanged: (val) => setState(() {
                                      rememberMe = val ?? false;
                                    }),
                                  ),
                                  const Text("Remember me"),
                                  const Spacer(),
                                  if (isLogin)
                                    TextButton(
                                      onPressed: () {
                                        // TODO: Forgot Password
                                      },
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                          color: secondaryRed,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              if (_authError != null) ...[
                                Text(
                                  _authError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryRed,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 6,
                                    shadowColor: secondaryRed.withOpacity(0.5),
                                  ),
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          isLogin ? "Login" : "Create Account",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      isLogin
                                          ? "Don't have an account?"
                                          : "Already have an account?",
                                      style: const TextStyle(fontSize: 13),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogin = !isLogin;
                                        _authError = null;
                                      });
                                    },
                                    child: Text(
                                      isLogin ? "Create Account" : "Login",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: primaryRed,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Report as Guest Button
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UserMainScreen(
                                        selectedIndex: 1,
                                      ), // 1 = Report tab
                                    ),
                                  );
                                },
                                child: Text(
                                  "Report as Guest",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryRed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: secondaryRed),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.grey[100],
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryRed, width: 2),
        ),
      ),
      validator: (val) {
        if (label == "Email") {
          return val == null || !val.contains('@')
              ? "Enter a valid email"
              : null;
        } else if (label == "Password") {
          return val == null || val.length < 6
              ? "Password must be at least 6 chars"
              : null;
        } else if (label == "Username" && !isLogin) {
          return val == null || val.isEmpty ? "Username required" : null;
        }
        return null;
      },
    );
  }
}

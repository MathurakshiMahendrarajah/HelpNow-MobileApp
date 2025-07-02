import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/home_tab.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController(); // Added

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Create Account"),
        backgroundColor: Color(0xFFFFCCBC),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            color: Colors.white.withOpacity(0.97),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "Welcome Back!" : "Create Your Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Username field only for Create Account
                    if (!isLogin) ...[
                      TextFormField(
                        controller: _usernameCtrl,
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.deepOrange,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => isLogin
                            ? null
                            : (val == null || val.trim().isEmpty
                                  ? "Username is required"
                                  : null),
                      ),
                      const SizedBox(height: 18),
                    ],
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.deepOrange,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || !val.contains('@')
                          ? "Enter a valid email"
                          : null,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.deepOrange,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.length < 6
                          ? "Password too short"
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: Colors.deepOrange,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = val ?? false;
                            });
                          },
                        ),
                        const Text("Remember me"),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UserMainScreen(isMember: true),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          isLogin ? "Login" : "Create Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin
                              ? "Don't have an account?"
                              : "Already have an account?",
                          style: TextStyle(fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? "Create Account" : "Login",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

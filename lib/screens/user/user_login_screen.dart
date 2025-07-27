import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/confirmsignup_screen.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';
import 'package:helpnow_mobileapp/services/amplify_service.dart';

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
  final TextEditingController _usernameCtrl = TextEditingController();
  final AmplifyService _amplifyService = AmplifyService();

  bool _isLoading = false;
  String? _authError;

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
        setState(() {
          _authError = result;
        });
        return;
      }
    } else {
      final result = await _amplifyService.signUp(
        username: _usernameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      if (result != 'SUCCESS' && result != 'CONFIRMATION_REQUIRED') {
        setState(() {
          _authError = result;
        });
        return;
      }

      if (result == 'CONFIRMATION_REQUIRED') {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ConfirmSignUpScreen(
        username: _usernameCtrl.text.trim(),
      ),
    ),
  );
  return;
}
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => UserMainScreen(),
      ),
    );
  } catch (e) {
    setState(() {
      _authError = e.toString();
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  void _forgotPassword() {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _codeCtrl = TextEditingController();
  final TextEditingController _newPasswordCtrl = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      bool codeSent = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Reset Password"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!codeSent) ...[
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: InputDecoration(
                      labelText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ] else ...[
                  TextFormField(
                    controller: _codeCtrl,
                    decoration: InputDecoration(
                      labelText: "Verification Code",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _newPasswordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              if (!codeSent)
                TextButton(
                  onPressed: () async {
                    try {
                      await _amplifyService.forgotPassword(
                        username: _emailCtrl.text.trim(),
                      );
                      setState(() {
                        codeSent = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Code sent to email.")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  },
                  child: Text("Send Code"),
                )
              else
                TextButton(
                  onPressed: () async {
                    try {
                      await _amplifyService.confirmForgotPassword(
                        username: _emailCtrl.text.trim(),
                        newPassword: _newPasswordCtrl.text,
                        confirmationCode: _codeCtrl.text,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password successfully reset.")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  },
                  child: Text("Confirm Reset"),
                ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      );
    },
  );
}

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Create Account"),
        backgroundColor: const Color(0xFFFFCCBC),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 22.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "Welcome Back!" : "Create Your Account",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (!isLogin) ...[
                      TextFormField(
                        controller: _usernameCtrl,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person_outline,
                              color: Colors.deepOrange),
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
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon:
                            Icon(Icons.email_outlined, color: Colors.deepOrange),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || !val.contains('@')
                              ? "Enter a valid email"
                              : null,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.deepOrange),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) =>
                          val == null || val.length < 6
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
                        const Spacer(),
                        TextButton(
                          onPressed: isLogin ? _forgotPassword : null,
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                    if (_authError != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _authError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(fontSize: 13),
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
                            style: const TextStyle(
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

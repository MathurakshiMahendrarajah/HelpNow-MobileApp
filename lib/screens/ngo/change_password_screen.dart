import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            passwordField(
              label: "Current Password",
              controller: currentController,
            ),
            const SizedBox(height: 20),
            passwordField(
              label: "New Password",
              controller: newController,
            ),
            const SizedBox(height: 20),
            passwordField(
              label: "Confirm New Password",
              controller: confirmController,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_reset),
              label: const Text("Update Password"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Add password update logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password updated")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
              isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey),
          onPressed: () => setState(() => isObscured = !isObscured),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}

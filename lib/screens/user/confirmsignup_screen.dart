import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/services/amplify_service.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String username;

  const ConfirmSignUpScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ConfirmSignUpScreenState createState() => _ConfirmSignUpScreenState();
}

class _ConfirmSignUpScreenState extends State<ConfirmSignUpScreen> {
  final TextEditingController _codeController = TextEditingController();
  final AmplifyService _amplifyService = AmplifyService();
  bool _isLoading = false;
  String? _error;

  Future<void> _confirm() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final code = _codeController.text.trim();

    if (code.isEmpty) {
      setState(() {
        _error = "Please enter the confirmation code.";
        _isLoading = false;
      });
      return;
    }

    final result = await _amplifyService.confirmSignUp(
      username: widget.username,
      confirmationCode: code,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == 'SUCCESS') {
      // Navigate to login screen or main screen
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account confirmed! Please log in.')),
      );
    } else {
      setState(() {
        _error = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Enter the confirmation code sent to your email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Confirmation Code',
                border: OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _confirm,
                    child: Text('Confirm'),
                  ),
          ],
        ),
      ),
    );
  }
}

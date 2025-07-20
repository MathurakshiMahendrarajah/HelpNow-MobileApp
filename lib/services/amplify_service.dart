import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class AmplifyService {
  // Sign up with email and password, optionally with username
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(userAttributes: {
          AuthUserAttributeKey.email: email,
        }),
      );
      return result.isSignUpComplete ? 'SUCCESS' : 'CONFIRMATION_REQUIRED';
    } on AuthException catch (e) {
      return e.message;
    }
  }

  // Sign in with username/email and password
  Future<String> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return result.isSignedIn ? 'SUCCESS' : 'FAILED';
    } on AuthException catch (e) {
      return e.message;
    }
  }

  // Forgot password - initiate password reset
  Future<String> forgotPassword({required String username}) async {
    try {
      final result = await Amplify.Auth.resetPassword(username: username);
      return result.isPasswordReset ? 'SUCCESS' : 'CONFIRMATION_REQUIRED';
    } on AuthException catch (e) {
      return e.message;
    }
  }

  // Confirm password reset with code and new password
  Future<String> confirmPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      await Amplify.Auth.confirmResetPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      return 'SUCCESS';
    } on AuthException catch (e) {
      return e.message;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      // handle error if needed
      print('Sign out error: ${e.message}');
    }
  }

  // Check current user session
  Future<bool> isSignedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } on AuthException {
      return false;
    }
  }

  Future<String> confirmSignUp({
  required String username,
  required String confirmationCode,
}) async {
  try {
    final res = await Amplify.Auth.confirmSignUp(
      username: username,
      confirmationCode: confirmationCode,
    );
    return res.isSignUpComplete ? 'SUCCESS' : 'FAILED';
  } on AuthException catch (e) {
    return e.message;
  }
}

}

import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/report_form.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class RouteConfig {
  static const String home = '/';
  static const String login = '/login';
  static const String reportForm = '/report-form';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => LoginScreen(),
    reportForm: (context) => const ReportFormScreen(),
  };
}

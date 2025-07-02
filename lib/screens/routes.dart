import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/ngo/ngo_login_screen.dart';
import 'package:helpnow_mobileapp/screens/role_selection_screen.dart';
import 'package:helpnow_mobileapp/screens/user/report_tab.dart';
import 'welcome_screen.dart';
import '../screens/splash_screen.dart';


class RouteConfig {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String reportForm = '/report-form';
  static const String user = '/user';
  static const String role_select = '/role-select';
  static const String ngo_login = '/ngo-login';
  static const String volunteer_login = '/volunteer-login';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    welcome: (context) =>  WelcomeScreen(),
    role_select: (context) => const RoleSelectionScreen(),
    ngo_login: (context) =>  NGOSignInScreen(),         // Create this
    // volunteer_login: (context) => const VolunteerLoginScreen(), // Create this
    reportForm: (context) => const ReportTab(),
    user: (context) => WelcomeScreen(),
  };
}

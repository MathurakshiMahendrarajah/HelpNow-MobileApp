import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/routes.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_api/amplify_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  final authPlugin = AmplifyAuthCognito();
  final storagePlugin = AmplifyStorageS3();     // 👈 Add this
  final apiPlugin = AmplifyAPI();  


  try {
    await Amplify.addPlugins([
      authPlugin,
      storagePlugin,
      apiPlugin,
    ]);

    await Amplify.configure(amplifyconfig);
    safePrint('✅ Amplify configured');
  } catch (e) {
    safePrint('❌ Amplify configuration failed: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelpNow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: RouteConfig.splash,
      routes: RouteConfig.routes,
    );
  }
}

import 'package:chatt_app_frontend/pages/home_page.dart';
import 'package:chatt_app_frontend/pages/login_page.dart';
import 'package:chatt_app_frontend/pages/profile_page.dart';
import 'package:chatt_app_frontend/pages/signup_page.dart';
import 'package:chatt_app_frontend/provider/token_provider.dart';
import 'package:chatt_app_frontend/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        // home: const ProfilePage(),
        initialRoute: MyRoutes.HomePage,
        debugShowCheckedModeBanner: false,
        routes: {
          MyRoutes.ProfilePage: (context) => const ProfilePage(),
          MyRoutes.HomePage: (context) => HomePage(),
          MyRoutes.LoginPage: (context) => const LoginPage(),
          MyRoutes.SignuPage: (context) => SignuPage(),
        },
      ),
    );
  }
}

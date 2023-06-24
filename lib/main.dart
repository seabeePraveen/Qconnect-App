import 'package:chatt_app_frontend/pages/profile_page.dart';
import 'package:chatt_app_frontend/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfilePage(),
      // initialRoute: MyRoutes.ProfilePage,
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.ProfilePage: (context) => const ProfilePage(),
      },
    );
  }
}

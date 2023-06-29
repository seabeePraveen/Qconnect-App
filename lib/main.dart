import 'package:chatt_app_frontend/pages/home_page.dart';
import 'package:chatt_app_frontend/pages/login_page.dart';
import 'package:chatt_app_frontend/pages/message_page.dart';
import 'package:chatt_app_frontend/pages/profile_page.dart';
import 'package:chatt_app_frontend/pages/search_page.dart';
import 'package:chatt_app_frontend/pages/signup_page.dart';
import 'package:chatt_app_frontend/provider/token_provider.dart';
import 'package:chatt_app_frontend/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: GetMaterialApp(
        // home: const ProfilePage(),
        initialRoute: MyRoutes.LoginPage,
        debugShowCheckedModeBanner: false,
        routes: {
          MyRoutes.ProfilePage: (context) => const ProfilePage(),
          MyRoutes.HomePage: (context) => HomePage(),
          MyRoutes.LoginPage: (context) => const LoginPage(),
          MyRoutes.SignuPage: (context) => SignuPage(),
          MyRoutes.SearchPage: (context) => const SearchPage(),
          MyRoutes.MessagePage: (context) => const MessagePage(),
        },
      ),
    );
  }
}

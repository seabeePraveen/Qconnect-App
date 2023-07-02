import 'package:Qconnect/pages/change_password.dart';
import 'package:Qconnect/pages/home_page.dart';
import 'package:Qconnect/pages/login_page.dart';
import 'package:Qconnect/pages/message_page.dart';
import 'package:Qconnect/pages/profile_options.dart';
import 'package:Qconnect/pages/profile_page.dart';
import 'package:Qconnect/pages/search_page.dart';
import 'package:Qconnect/pages/signup_page.dart';
import 'package:Qconnect/provider/token_provider.dart';
import 'package:Qconnect/utils/routes.dart';
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
          MyRoutes.ProfileOptionsPage: (context) => ProfileOptionsPage(),
          MyRoutes.ChangePasswordPage: (context) => ChangePassword(),
        },
      ),
    );
  }
}

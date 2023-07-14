// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_local_variable

import 'package:Qconnect/constants.dart';
import 'package:Qconnect/provider/token_provider.dart';
import 'package:Qconnect/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileOptionsPage extends StatelessWidget {
  const ProfileOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(baseURL +
                                "/api" +
                                authProvider.user.profile_pic),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authProvider.user.username!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            authProvider.user.email!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Container(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.ProfilePage);
                  },
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.edit_note,
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                        flex: 80,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Container(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.ChangePasswordPage);
                  },
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.password,
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                        flex: 80,
                        child: Text(
                          "Change Password",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Container(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.ProfilePage);
                  },
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.contact_support,
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                        flex: 80,
                        child: Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Container(
                child: InkWell(
                  onTap: () {
                    authProvider.logout();
                    authProvider.setLoggedStatus(false);
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyRoutes.LoginPage,
                        (route) => route.settings.name == MyRoutes.LoginPage);
                  },
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Icon(
                          Icons.logout,
                          size: 32,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(flex: 5, child: SizedBox()),
                      Expanded(
                        flex: 80,
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  var response = await http.post(
                    Uri.parse("$baseURL/api/delete/"),
                    body: {"token": authProvider.token},
                  );
                  authProvider.logout();
                  authProvider.setLoggedStatus(false);
                  Navigator.pushNamedAndRemoveUntil(context, MyRoutes.LoginPage,
                      (route) => route.settings.name == MyRoutes.LoginPage);
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 28,
                          color: Colors.white,
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

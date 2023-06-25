// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, sort_child_properties_last

import 'dart:convert';

import 'package:chatt_app_frontend/provider/token_provider.dart';
import 'package:chatt_app_frontend/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String? name;
  String? email;
  String? userid;

  @override
  void initState() {
    super.initState();
    get_data();
  }

  get_data() async {
    final authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.loggedstatus);
    print(authProvider.token);
    // var response = await http.post(
    //   Uri.parse("http://10.0.2.2:8000/api/get_user/"),
    //   body: {"token": authProvider.token},
    // );

    // var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    // _nameController.text = jsonResponse['name'];
    // _userIDController.text = jsonResponse['userid'];
    // _emailController.text = jsonResponse['email'];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromARGB(255, 255, 255, 255)),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.HomePage);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                          child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 12),
                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 32 * 1.5,
                        backgroundImage: AssetImage("assets/profile_image.png"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile Picture",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 35,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        )),
                    Expanded(
                      flex: 75,
                      child: TextFormField(
                        controller: _nameController,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 35,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "UserID",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        )),
                    Expanded(
                      flex: 75,
                      child: TextFormField(
                        controller: _userIDController,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 35,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        )),
                    Expanded(
                      flex: 75,
                      child: TextField(
                        controller: _emailController,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

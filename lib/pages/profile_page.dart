// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userIDController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'CB Praveen';
    _userIDController.text = 'praveen_nonsense_';
    _emailController.text = "SVNIT'25 \nRemember me?";
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
                        onPressed: () {},
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

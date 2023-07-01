// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore, sort_child_properties_last, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:Qconnect/provider/token_provider.dart';
import 'package:Qconnect/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void imagePickerOption() {
    Get.bottomSheet(SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // ignore: avoid_unnecessary_containers
        child: Container(
          color: Colors.white,
          height: 400,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 15, left: 120, right: 120, bottom: 15),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color.fromRGBO(48, 79, 254, 0.1),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 32,
                                    color: Color(0xFF304FFE),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Take Photo",
                              style: TextStyle(
                                  fontSize: 32 * 0.64,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all(style: BorderStyle.solid, width: .2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 15, left: 115, right: 115, bottom: 15),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color.fromRGBO(48, 79, 254, 0.1),
                                  ),
                                  child: const Icon(
                                    Icons.filter,
                                    size: 32,
                                    color: Color(0xFF304FFE),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "From Gallery",
                              style: TextStyle(
                                  fontSize: 32 * 0.64,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                style: BorderStyle.solid, width: .15),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromARGB(255, 255, 255, 255)),
    );
    final authProvider = Provider.of<AuthProvider>(context);
    _nameController.text = authProvider.user.name!;
    _emailController.text = authProvider.user.email!;
    _usernameController.text = authProvider.user.username!;
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
                          Navigator.pop(context);
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
                        onPressed: () async {
                          var res = await authProvider.userUpdate(
                              _usernameController.text.toString(),
                              _emailController.text,
                              _nameController.text.toString());
                          if (res.runtimeType == String) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 200,
                                      width: 250,
                                      child: Text(res as String),
                                    ),
                                  );
                                });
                          } else {
                            Navigator.pop(context);
                          }
                        },
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
                      CircleAvatar(
                        radius: 32 * 1.5,
                        backgroundImage: NetworkImage('http://10.0.2.2:8000' +
                            authProvider.user.profile_pic),
                      ),
                      TextButton(
                        onPressed: () {
                          imagePickerOption();
                        },
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
                            "User Name",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w400),
                          ),
                        )),
                    Expanded(
                      flex: 75,
                      child: TextFormField(
                        controller: _usernameController,
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

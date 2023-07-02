import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/token_provider.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _oldPassword = TextEditingController();

  TextEditingController _newPassword = TextEditingController();

  TextEditingController _confirmNewPassword = TextEditingController();
  bool corretPasswords = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: TextFormField(
              controller: _oldPassword,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Current Password",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: TextFormField(
              controller: _newPassword,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "New Password",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: TextFormField(
              controller: _confirmNewPassword,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Re Enter New Password",
              ),
            ),
          ),
          corretPasswords
              ? const Text("")
              : const Text(
                  "Passwords are not matched!",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: InkWell(
                onTap: () async {
                  if (_newPassword.text == _confirmNewPassword.text) {
                    setState(() {
                      corretPasswords = true;
                    });
                    var res = authProvider.changePassword(
                        _oldPassword.text.toString(),
                        _newPassword.text.toString());
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
                  } else {
                    setState(() {
                      corretPasswords = false;
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

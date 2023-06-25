import 'package:chatt_app_frontend/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';

class SignuPage extends StatefulWidget {
  SignuPage({super.key});

  @override
  State<SignuPage> createState() => _SignuPageState();
}

class _SignuPageState extends State<SignuPage> {
  TextEditingController _useridController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool error_cond = false;
  String? error_message;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/insta_logo.png",
                      height: 64,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(fontSize: 24),
                          ),
                          error_cond
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    "Passwords are not matched!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : const Text(""),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 6),
                    child: TextFormField(
                      controller: _useridController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "User ID",
                        labelText: "User ID",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 6),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 6),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 6),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Re-Enter Password",
                        labelText: "Re-Enter Password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: InkWell(
                      onTap: () {
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          setState(() {
                            error_cond = true;
                          });
                        } else {
                          setState(() {
                            error_cond = false;
                          });
                          authProvider.register(
                            _useridController.text.toString(),
                            _emailController.text.toString(),
                            _passwordController.text.toString(),
                          );
                          if (authProvider.loggedstatus) {
                            Navigator.pushNamed(context, MyRoutes.HomePage);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Text("Signup"),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have a account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.LoginPage);
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

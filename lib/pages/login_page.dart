// ignore_for_file: use_build_context_synchronously

import 'package:Qconnect/provider/token_provider.dart';
import 'package:Qconnect/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _useridController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/Qconnect_logo.jpeg",
                height: 64,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "Qconnect",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 6),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var res = await authProvider.login(
                    _useridController.text.toString(),
                    _passwordController.text.toString());
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
                }
                if (authProvider.loading) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: 250,
                            child: const Text("Loading"),
                          ),
                        );
                      });
                }
                if (authProvider.loggedstatus) {
                  Navigator.popAndPushNamed(context, MyRoutes.HomePage);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text("Login"),
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have a account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.SignuPage);
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

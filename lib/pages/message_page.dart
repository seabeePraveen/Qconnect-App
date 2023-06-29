// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/token_provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Map data = {};
  List<dynamic> messages = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> get_messages() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/get/"),
        body: {"host": data['host'], "user2": data['user2']},
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        messages = jsonResponse;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: .5,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('http://10.0.2.2:8000' +
                        (data['user2_profile_pic'] ?? '')),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              data['user2'] ?? 'admin',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 91,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage('http://10.0.2.2:8000' +
                                      (data['user2_profile_pic'] ?? '')),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  data['user2'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: Text(
                                        "View Profile",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Expanded(
              flex: 9,
              child: Container(
                child: Row(
                  children: [
                    const Expanded(
                      flex: 85,
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: "Message...",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 13,
                      child:
                          InkWell(onTap: () {}, child: const Icon(Icons.send)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

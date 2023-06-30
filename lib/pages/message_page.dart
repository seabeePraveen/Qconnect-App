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
    get_messages();
  }

  Future<void> get_messages() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/get/"),
        body: {"host": data['host'], "user2": data['user2']},
      );
      var jsonResponse = jsonDecode(response.body);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  get_messages();
                  print(messages);
                },
                child: Icon(Icons.refresh),
              ),
            )
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children:
                        buildDataWidgets(), // Build the column widgets dynamically
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

  List<Widget> buildDataWidgets() {
    List<Widget> widgets = [];

    // Build widgets based on the fetched data
    for (var data in messages) {
      // Customize the widget as per your requirement
      Widget dataWidget = MessageWiget();

      widgets.add(dataWidget);
    }

    return widgets;
  }
}

class MessageWiget extends StatelessWidget {
  const MessageWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(),
              color: Color(0xFFEEEEEF)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Text(
              "this is a sample messag to check how this is working",
              style: TextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}

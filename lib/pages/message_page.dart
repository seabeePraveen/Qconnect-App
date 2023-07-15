// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:Qconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/token_provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Map data = {};
  List<dynamic> messages = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    get_messages();
    scroll_to_bottom();
    // startTimer();
  }

  void scroll_to_bottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> get_messages() async {
    try {
      var response = await http.post(
        Uri.parse("$baseURL/api/get/"),
        body: {"host": data['host'], "user2": data['user2']},
      );
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        messages = jsonResponse;
      });
    } catch (e) {}
  }

  Future<void> send_message(String content, String host, String user2) async {
    try {
      await http.post(
        Uri.parse("$baseURL/api/send/"),
        body: {"host": host, "user2": user2, 'content': content},
      );
      setState(() {
        _messageController.clear();
        get_messages();
        scroll_to_bottom();
      });
    } catch (e) {}
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (_) {
      get_messages();
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: .5,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        baseURL + "/api" + (data['user2_profile_pic'] ?? '')),
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
                child: const Icon(Icons.refresh),
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
              controller: _scrollController,
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
                                  image: NetworkImage(baseURL +
                                      "/api" +
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
                    children: buildDataWidgets(data['user2_profile_pic']),
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
                    Expanded(
                      flex: 85,
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        onTap: () {
                          scroll_to_bottom();
                        },
                        decoration: const InputDecoration(
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
                      child: InkWell(
                          onTap: () {
                            var content = _messageController.text;
                            var host = authProvider.user.username;
                            var user2 = data['user2'];
                            send_message(content, host!, user2);
                          },
                          child: const Icon(Icons.send)),
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

  List<Widget> buildDataWidgets(String user2_profile_pic) {
    List<Widget> widgets = [];

    for (var data in messages) {
      Widget dataWidget = MessageWiget(
          message: data['content'],
          user: data['user'],
          sender: data['sender'],
          user2_profile_pic: user2_profile_pic);

      widgets.add(dataWidget);
    }

    return widgets;
  }
}

class MessageWiget extends StatelessWidget {
  String message;
  int user;
  int sender;
  String user2_profile_pic;

  MessageWiget(
      {super.key,
      required this.message,
      required this.user,
      required this.sender,
      required this.user2_profile_pic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      child: user == sender
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(),
                      color: const Color(0xFFEEEEEF)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Text(
                      message,
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
            )
          : Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            baseURL + "/api" + (user2_profile_pic)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(),
                        color: const Color(0xFFEEEEEF)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      child: Text(
                        message,
                        style: const TextStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

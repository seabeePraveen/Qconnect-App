// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:Qconnect/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:Qconnect/provider/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  var base_url = "https://qconnectbackend.onrender.com/api/";

  List<dynamic> homedata = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    get_details();
    startTimer();
  }

  void get_details() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      var response = await http.post(
        Uri.parse("${base_url}get_last_messages_of_user_and_details/"),
        body: {"token": authProvider.token},
      );
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        homedata = jsonResponse;
      });
    } catch (e) {}
  }

  void startTimer() {
    const duration = Duration(seconds: 2);
    timer = Timer.periodic(duration, (_) {
      get_details();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // get_details();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyRoutes.ProfileOptionsPage);
                        },
                        child: CircleAvatar(
                          radius: 32,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://qconnectbackend.onrender.com' +
                                        authProvider.user.profile_pic),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 60,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.SearchPage);
                        },
                        child: const Icon(
                          Icons.search,
                          size: 28,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            get_details();
                          });
                        },
                        child: Container(
                          child: const Icon(
                            Icons.refresh,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.search), // Icon leading to the input field
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children:
                    buildDataWidgets(), // Build the column widgets dynamically
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildDataWidgets() {
    List<Widget> widgets = [];

    for (var data in homedata) {
      Widget dataWidget = EachUserWidget(
        username: data['user2_username'],
        message: data['content'],
        profile_pic: data['user2_pic'],
        host: data['user'],
        sender: data['sender'],
      );

      widgets.add(dataWidget);
    }

    return widgets;
  }
}

class EachUserWidget extends StatelessWidget {
  String username;
  String message;
  String profile_pic;
  int host;
  int sender;
  EachUserWidget({
    Key? key,
    required this.username,
    required this.message,
    required this.profile_pic,
    required this.host,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
      child: Container(
        width: double.maxFinite,
        height: 64,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://qconnectbackend.onrender.com' + profile_pic),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.MessagePage,
                      arguments: {
                        'user2': username,
                        'host': authProvider.user.username,
                        'user2_profile_pic': profile_pic
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          if (host == sender)
                            const Text(
                              "You: ",
                              style: TextStyle(color: Colors.blue),
                            ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text(
                              message,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchUserController = TextEditingController();

  List<dynamic> data = [];

  void search_users(String username) async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/get_user_with_string/"),
      body: {"username": username},
    );

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      data = jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Expanded(
                      flex: 10,
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 90,
                    child: Container(
                      child: TextFormField(
                        controller: _searchUserController,
                        cursorHeight: 28,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            search_users(value);
                          } else {
                            data.clear();
                          }
                        },
                        style: const TextStyle(fontSize: 20),
                        decoration:
                            const InputDecoration(hintText: "Search User"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/profile_image.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        data[index]['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        data[index]['email'],
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

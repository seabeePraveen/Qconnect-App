import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../pages/home_page.dart';
import '../utils/routes.dart';

class AuthProvider with ChangeNotifier {
  bool _loggedstatus = false;
  bool get loggedstatus => _loggedstatus;
  String _token = "Null";
  String get token => _token;

  void setLoggedStatus(bool val) {
    _loggedstatus = val;
    notifyListeners();
  }

  setToken(String tok) {
    _token = tok;
    notifyListeners();
  }

  void login(String userid, String password) async {
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login/"),
        body: {"userid": userid, "password": password},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        setLoggedStatus(true);
      } else if (response.statusCode == 404) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
      }
    } catch (e) {}
  }

  void register(String userid, String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/register/"),
        body: {"userid": userid, "email": email, "password": password},
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        setLoggedStatus(true);
      } else if (response.statusCode == 404) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
      }
    } catch (e) {}
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model.dart';

class AuthProvider with ChangeNotifier {
  bool _loggedstatus = false;
  bool get loggedstatus => _loggedstatus;
  String _token = "Null";
  String get token => _token;
  User _user = User(
      name: "admin",
      username: "admin",
      email: "admin@gmail.com",
      phone_number: "12345678");
  User get user => _user;

  void setLoggedStatus(bool val) {
    _loggedstatus = val;
    notifyListeners();
  }

  void setToken(String tok) {
    _token = tok;
    notifyListeners();
  }

  void setUser(
      String username, String email, String name, String phone_number) {
    _user = User(
        email: email,
        username: username,
        name: name,
        phone_number: phone_number);
    notifyListeners();
  }

  void login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login/"),
        body: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        var userDetails = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/get_user/"),
          body: {"token": token},
        );

        if (userDetails.statusCode == 200) {
          var newJsonResponse = jsonDecode(userDetails.body);
          if (newJsonResponse['name'] == null) {
            newJsonResponse['name'] = "None";
          }
          if (newJsonResponse['phone_number'] == null) {
            newJsonResponse['phone_number'] = "None";
          }
          setUser(newJsonResponse['username'], newJsonResponse['email'],
              newJsonResponse['name'], newJsonResponse['phone_number']);
          setLoggedStatus(true);
        }
      } else if (response.statusCode == 404) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      }
    } catch (e) {}
  }

  void register(String username, String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/register/"),
        body: {"username": username, "email": email, "password": password},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        var userDetails = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/get_user/"),
          body: {"token": token},
        );

        if (userDetails.statusCode == 200) {
          var newJsonResponse = jsonDecode(userDetails.body);
          if (newJsonResponse['name'] == null) {
            newJsonResponse['name'] = "None";
          }
          if (newJsonResponse['phone_number'] == null) {
            newJsonResponse['phone_number'] = "None";
          }
          setUser(newJsonResponse['username'], newJsonResponse['email'],
              newJsonResponse['name'], newJsonResponse['phone_number']);
          setLoggedStatus(true);
        }
      } else {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      }
    } catch (e) {}
  }

  void userUpdate(String username, String email, String name) async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/update/"),
      body: {
        "username": username,
        "email": email,
        "token": token,
        "name": name
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var userDetails = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/get_user/"),
        body: {"token": token},
      );

      if (userDetails.statusCode == 200) {
        var newJsonResponse = jsonDecode(userDetails.body);
        if (newJsonResponse['name'] == null) {
          newJsonResponse['name'] = "None";
        }
        if (newJsonResponse['phone_number'] == null) {
          newJsonResponse['phone_number'] = "None";
        }
        setUser(newJsonResponse['username'], newJsonResponse['email'],
            newJsonResponse['name'], newJsonResponse['phone_number']);
        setLoggedStatus(true);
      }
    } else {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    }
  }
}

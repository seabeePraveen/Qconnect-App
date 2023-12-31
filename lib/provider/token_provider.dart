import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../model.dart';

class AuthProvider with ChangeNotifier {
  bool _loggedstatus = false;
  bool get loggedstatus => _loggedstatus;
  bool _loading = false;
  bool get loading => _loading;
  String _token = "Null";
  String get token => _token;
  User _user = User(
      name: "admin",
      username: "admin",
      email: "admin@gmail.com",
      phone_number: "12345678",
      profile_pic: "xxxx");
  User get user => _user;

  void setLoggedStatus(bool val) {
    _loggedstatus = val;
    notifyListeners();
  }

  void changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void setToken(String tok) {
    _token = tok;
    notifyListeners();
  }

  void setUser(String username, String email, String name, String phone_number,
      String profile_pic) {
    _user = User(
        email: email,
        username: username,
        name: name,
        phone_number: phone_number,
        profile_pic: profile_pic);
    notifyListeners();
  }

  Future<dynamic> login(String username, String password) async {
    try {
      changeLoading(true);
      var response = await http.post(
        Uri.parse("$baseURL/api/login/"),
        body: {"username": username, "password": password},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        var userDetails = await http.post(
          Uri.parse("$baseURL/api/get_user/"),
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
          setUser(
              newJsonResponse['username'],
              newJsonResponse['email'],
              newJsonResponse['name'],
              newJsonResponse['phone_number'],
              newJsonResponse['profile_pic']);
          setLoggedStatus(true);
          changeLoading(false);
        }
      } else if (response.statusCode == 404) {
        changeLoading(false);
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey("error")) {
          return jsonResponse["error"];
        }
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> register(
      String username, String email, String password) async {
    try {
      changeLoading(true);
      var response = await http.post(
        Uri.parse("$baseURL/api/register/"),
        body: {"username": username, "email": email, "password": password},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setToken(jsonResponse['token']);
        var userDetails = await http.post(
          Uri.parse("$baseURL/api/get_user/"),
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
          setUser(
              newJsonResponse['username'],
              newJsonResponse['email'],
              newJsonResponse['name'],
              newJsonResponse['phone_number'],
              newJsonResponse['profile_pic']);
          setLoggedStatus(true);
          changeLoading(false);
        }
      } else {
        changeLoading(false);
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey("username")) {
          return jsonResponse["username"];
        }
        if (jsonResponse.containsKey("email")) {
          return jsonResponse["email"];
        }
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> changePassword(String oldPass, String newPass) async {
    var response = await http.post(
      Uri.parse("$baseURL/api/change_password/"),
      body: {"token": token, "oldPassword": oldPass, "newPassword": newPass},
    );
    if (response.statusCode == 200) {
      print("succesfull");
      return null;
    } else {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey("error")) {
        return jsonResponse["error"];
      }
    }
  }

  void logout() {
    setToken("Null");
    setUser("null", "null", "null", "null", "null");
  }

  Future<dynamic> userUpdate(String username, String email, String name) async {
    var response = await http.post(
      Uri.parse("$baseURL/api/update/"),
      body: {
        "username": username,
        "email": email,
        "token": token,
        "name": name
      },
    );
    if (response.statusCode == 200) {
      var userDetails = await http.post(
        Uri.parse("$baseURL/api/get_user/"),
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
        setUser(
            newJsonResponse['username'],
            newJsonResponse['email'],
            newJsonResponse['name'],
            newJsonResponse['phone_number'],
            newJsonResponse['profile_pic']);
        setLoggedStatus(true);
      }
    } else {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey("username")) {
        return jsonResponse["username"];
      }
      if (jsonResponse.containsKey("email")) {
        return jsonResponse["email"];
      }
    }
  }
}

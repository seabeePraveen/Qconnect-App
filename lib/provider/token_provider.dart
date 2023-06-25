import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void login(String userid, String password) async {
    setLoading(true);
    try {
      var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login/"),
        body: {
          "userid": userid,
          "password": password,
        },
      );

      print(response.statusCode);
      var jsonResponse = jsonDecode(response.body);
      setLoading(false);
      print(jsonResponse);
    } catch (e) {
      print(e);
    }
  }
}

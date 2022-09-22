import 'dart:developer';
import 'dart:convert';
import 'package:eventatt/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Net {
  String scanned;
  final String apiurl = "http://18.222.254.209/users/";
  Net(this.scanned) {
    log(scanned.toString());
  }
  Future<dynamic> getRequest(String token) async {
    http.Response response = await http.get(Uri.parse(apiurl + "qr/$scanned"));
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log(decodedData);
        return decodedData;
      } else {
        return "Failed.";
      }
    } catch (exp) {
      log(exp.toString());
    }
  }
}

class Login {
  String apiurl = "http://18.222.254.209/auth/login";
  String? token;

  Future<dynamic> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    http.Response response = await http
        .post(Uri.parse(apiurl), body: {"email": email, "password": password});
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        token = decodedData["tokens"]["access"]["token"];
        prefs.setString("token", token!);
        return token;
      }
    } catch (exp) {
      log(exp.toString());
      return null;
    }
  }

  Future<String?> loginToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}

class UserRequests {
  String apiurl = "http://18.222.31.63/users";

  Future<dynamic> getUser(String qr) async {
    http.Response response = await http.get(Uri.parse("$apiurl/qr/$qr"));
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log(decodedData.toString());
        return decodedData['registerNumber'];
      }
    } catch (exp) {
      log(exp.toString());
    }
  }

  Future<dynamic> markAttendance(String id, BuildContext context) async {
    http.Response response = await http.patch(
      Uri.parse("$apiurl/$id"),
      body: {"isPresent": "true"},
    );
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Attendance marked.")));
      }
    } catch (exp) {
      log(exp.toString());
    }
  }

  Future<dynamic> markFood(String id, BuildContext context) async {
    http.Response response = await http.patch(
      Uri.parse("$apiurl/$id"),
      body: {"hasEaten": "true"},
    );
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Refreshments delivered.")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Refreshments not delivered.")));
      }
    } catch (exp) {
      log(exp.toString());
    }
  }
}

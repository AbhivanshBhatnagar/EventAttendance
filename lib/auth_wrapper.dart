import 'package:eventatt/login.dart';
import 'package:eventatt/networking.dart';
import 'package:eventatt/scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Login().loginToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            return Scanner();
          } else {
            return LoginScreen();
          }
        });
  }
}

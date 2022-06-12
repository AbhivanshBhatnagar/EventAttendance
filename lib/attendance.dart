import 'dart:convert';

import 'package:eventatt/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'user_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key, required String jwt, required User user})
      : _jwt = jwt,
        _user = user,
        super(key: key);

  final String _jwt;
  final User _user;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dec = JwtDecoder.decode(_jwt);
    bool isPresent = _user.isPresent!;
    bool hasEaten = _user.hasEaten!;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 5),
              Text(
                dec['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isPresent ? Colors.green : Colors.red,
                ),
                child: const Text('Attendance'),
                onPressed: () async {
                  await UserRequests().markAttendance(_user.id!, context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: hasEaten ? Colors.green : Colors.red,
                ),
                child: const Text('Food'),
                onPressed: () async {
                  await UserRequests().markFood(_user.id!, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

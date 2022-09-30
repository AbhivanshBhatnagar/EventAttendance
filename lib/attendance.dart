import 'dart:convert';
import 'scan.dart';
import 'package:eventatt/networking.dart';
import 'package:eventatt/scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'user_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen(
      {Key? key,
      required String jwt,
      required String rNo,
      required bool presence})
      : _jwt = jwt,
        _rNo = rNo,
        _presence = presence,
        super(key: key);

  final String _jwt;
  final String _rNo;
  final bool _presence;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dec = JwtDecoder.decode(_jwt);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Scanner(),
                ),
              );
            },
          ),
        ),
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
              Text(
                'Register Number:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 5),
              Text(
                dec['registerNumber'].toString().toUpperCase(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _presence ? Colors.green : Colors.red,
                ),
                child: const Text('Mark Attendance'),
                onPressed: () async {
                  await UserRequests().markAttendance(_rNo, context);
                },
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: hasEaten ? Colors.green : Colors.red,
              //   ),
              //   child: const Text('Food'),
              //   onPressed: () async {
              //     await UserRequests().markFood(_rNo, context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

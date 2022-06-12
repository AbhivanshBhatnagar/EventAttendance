import 'package:eventatt/home.dart';
import 'package:eventatt/scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'auth_wrapper.dart';

class EventAttendance extends StatefulWidget {
  const EventAttendance({Key? key}) : super(key: key);

  @override
  State<EventAttendance> createState() => _EventAttendanceState();
}

class _EventAttendanceState extends State<EventAttendance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

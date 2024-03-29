import 'dart:developer';
import 'dart:io';
import 'package:eventatt/attendance.dart';
import 'package:eventatt/networking.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'user_model.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  String? result;

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // controller?.resumeCamera();
  //   controller?.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          ElevatedButton(
            child: Text(
              barcode != null
                  ? JwtDecoder.decode(barcode!.code.toString())['name']
                  : 'Searching...',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () async {
              // log(JwtDecoder.decode(result as String).toString());
              String rNo = await UserRequests().getUser(JwtDecoder.decode(
                  barcode!.code.toString())['registerNumber']);
              // log(rNo);
              bool isPresent = await UserRequests().getAtt(rNo);
              // log(isPresent.toString());
              // log(user.isPresent.toString());
              controller?.pauseCamera();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceScreen(
                    jwt: result!,
                    rNo: rNo,
                    presence: isPresent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget qrtext() => Container(
        decoration: const BoxDecoration(color: Colors.white24),
        child: Text(barcode != null
            ? JwtDecoder.decode(barcode!.code.toString()).toString()
            : "Scan QR"),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.75,
          borderWidth: 5,
          borderRadius: 10,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    setState(() {
      controller.scannedDataStream.listen((barcode) {
        setState(() {
          this.barcode = barcode;
          result = barcode.code.toString();
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => AttendanceScreen(jwt: result!)));
      });
      controller.resumeCamera();
    });
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:eventatt/networking.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  var result;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller?.resumeCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        buildQrView(context),
        Positioned(bottom: 10, child: qrtext())
      ]),
    );
  }

  Widget qrtext() => Container(
        decoration: BoxDecoration(color: Colors.white24),
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
    setState(() {
      this.controller = controller;

      controller.scannedDataStream.listen((barcode) {
        setState(() {
          this.barcode = barcode;
          result = barcode.code.toString();

          Net(result);
        });
      });
    });
  }
}

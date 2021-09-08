import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:vtech/util/const.dart';
import 'package:vtech/widgets/cameraStream.dart';

class ScanQRCodeScreen extends StatefulWidget {
  @override
  _ScanQRCodeScreenState createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Scan QR code'),
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        iconTheme: IconThemeData(
         color: Colors.white
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          // Expanded(
          //   flex: 2,
          //     child: Container(
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Constants.primary,
          //       borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(16.0),
          //       topRight: Radius.circular(16.0),
          //     ),
          //     ),
          //     child: Text(
          //       'Camera Pairing QR Code',
          //       style: TextStyle(color: Constants.primary),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // final decoded = jsonDecode(scanData.code) as Map;
        print('Barcode Type: ${describeEnum(scanData.format)}   Data: ${scanData.code}');
        // print('Barcode Type: ${describeEnum(scanData.format)}   Data: ${scanData.code}');
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tech_express_booking_driver/service/cloud_firestore_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  Barcode? result;
  late bool _enableBtn;
  late bool _isLoading;

  Future<void> _onCheckOutUser() async {
    setState(() {
      _isLoading = true;
    });
    var res = await CloudFirestoreService.instance
        .updateScanningStatus(result!.code!);
    setState(() {
      _isLoading = false;
    });
    if (res is String) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(res)
            ],
          )));
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            content: Row(
              children: const [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Text('Ticket scanned successful')
              ],
            )))
        .closed
        .then((value) => {
              //Navigate here
            });
  }

  @override
  void initState() {
    super.initState();
    _enableBtn = false;
    _isLoading = false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        //found
        result = scanData;
        if (result?.format == BarcodeFormat.qrcode) {
          if (result?.code != null) {
            _enableBtn = true;
            return;
          }
        }
        _enableBtn = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 10),
            ),
          ),
          Expanded(
              child: TextButton(
                  onPressed: _enableBtn ? _onCheckOutUser : null,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Check out user;'))),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${result!.format}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }
}

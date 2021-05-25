import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/basic_controller.dart';
import 'package:udhaarkaroapp/controllers/transaction_controller.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';

class QRScanner extends StatefulWidget {
  final Function callback;

  QRScanner({@required this.callback});

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  final TransactionController _txnController = Get.find(tag: "txn-controller");
  final UserController _userController = Get.find(tag: "user-controller");
  final BasicController _basicController = Get.find(tag: "basic-control");

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      //controller.pauseCamera();
    } else if (Platform.isIOS) {
      //controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 0.40 * displayHeight(context),
          width: 0.70 * displayHeight(context),
          child: QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: lightOrangeColor,
                borderWidth: 10,
                borderLength: 30,
                cutOutSize: 250),
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        height10,
        Obx(() =>
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      _toggleFlash(controller);
                    },
                    child: (!_basicController.status.value)
                        ? Icon(
                      Icons.flash_on,
                      color: whiteColor,
                    )
                        : Icon(
                      Icons.flash_off,
                      color: whiteColor,
                    ))
              ],
            ),
        ),
        height10,
        Obx(() =>
            Text(
              _basicController.msg.value,
              style: TextStyle(color: lightOrangeColor),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
        ),
      ],
    );
  }

  void _toggleFlash(QRViewController controller) {
    this.controller = controller;
    controller.toggleFlash();
    _basicController.flashToggle();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s) != null;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        if (scanData.code.length == 10 &&
            isNumeric(scanData.code) &&
            int.parse(scanData.code[0]) >= 7) {
          if(scanData.code != _userController.userModel.value.mobileNumber) {
            controller.pauseCamera();
            _txnController.txnModel.value.number = scanData.code.toString();
            widget.callback(controller);
          }
          else{
            _basicController.msg.value = "You can't scan your own number's QR code";
          }
        }
        else {
          _basicController.msg.value = "Invalid QR code";
        }
      }
    });
  }
}

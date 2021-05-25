import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/TransactionOperation.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:udhaarkaroapp/widgets/qrScanner.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Map _data = {};
  final TransactionController _txnController = Get.find(tag: "txn-controller");
  final UserController _userController = Get.find(tag: "user-controller");
  final _formKey = GlobalKey<FormState>();
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 0.70 * displayHeight(context),
                      color: blackColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: whiteColor,
                                  size: 30,
                                )),
                          ),
                          Text("Scan any QR Code", style: h3_Light),
                          height10,
                          Container(
                              child: QRScanner(
                                callback: (QRViewController controller) async {
                                  await TxnOperation().operation(context, _data);
                                },
                              )),
                        ],
                      ),
                    ),
                    height5,
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text("OR",
                                style: t18_Dark),
                            height5,
                            PhoneTextField(
                              decoration: inputDecor2,
                              label: "Enter Phone Number",
                              callback: (value) {
                                _txnController.txnModel.value.number = value;
                              },
                            ),
                            height10,
                            height5,
                            Center(
                                child: SubmitButton(
                                  text: "Proceed",
                                  width: 200,
                                  height: 45,
                                  color: lightBlueColor,
                                  elevation: 5,
                                  formKey: _formKey,
                                  callback: () async {
                                    if (_txnController.txnModel.value.number !=
                                        _userController.userModel.value.mobileNumber) {
                                      await TxnOperation().operation(context, _data);
                                    }
                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(new SnackBar(
                                           content: new Text(
                                              "You can't enter your own number")
                                      ));
                                    }
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Obx(() =>
                Center(child: CircularLoader(load: _txnController.load.value)))
          ],
        ),
      ),
    );
  }
}

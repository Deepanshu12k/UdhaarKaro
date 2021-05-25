import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';

class TxnOperation{

  final TransactionController _txnController = Get.find(tag: "txn-controller");
  QRViewController controller;

  Future operation(context, data) async {
    await _txnController.getAnotherUserData(data["type"]);
    if(_txnController.response.value == "no data"){
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text("This Phone Number is not Registered")
      ));
    }
    else if(_txnController.response.value == "error"){
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text("Something went wrong or Probably server down")
      ));
      controller.resumeCamera();
    }
    else if(_txnController.response.value == "limit exceeded"){
      Alert().failSweetAlert(
          "Your transaction limit with this user has been exceeded.", context);
    }
    else{
      Navigate().toEnterAmount(context, data);
    }
  }
}
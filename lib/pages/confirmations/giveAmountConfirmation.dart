import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';

class GiveAmountConfirmation extends StatefulWidget {
  @override
  _GiveAmountConfirmationState createState() => _GiveAmountConfirmationState();
}

class _GiveAmountConfirmationState extends State<GiveAmountConfirmation> {
  Map data;
  int buildCount = 0;
  TransactionController _txnController = Get.find(tag: "txn-controller");

  Future add() async {
    await _txnController.addTransaction(data["type"]);
    if (_txnController.response.value == "success") {
      Timer(Duration(seconds: 2), () {
        Navigate().toGivenAmount(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildCount++;
    data = ModalRoute
        .of(context)
        .settings
        .arguments;
    if(buildCount == 1){add();}

    return Scaffold(
      body: Container(
        color: lightOrangeColor,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Giving Amount to",
                  style: t22_Light,
                ),
                height10,
                Text(
                  _txnController.txnModel.value.name,
                  style: h2_Light,
                ),
                height10,
                Text(
                  "Amount:- Rs ${_txnController.txnModel.value.amount}",
                  style: t18_Light,
                ),
                height60,
                Obx(() =>
                (_txnController.response.value == "success")
                    ? Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 250,
                    child: FlareActor(
                      "assets/successgreen.flr",
                      alignment: Alignment.center,
                      animation: "success",
                      fit: BoxFit.contain,
                      callback: (value) {
                        print(value);
                      },
                    ))
                    : Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 250,
                    child: FlareActor(
                      "assets/loading.flr",
                      alignment: Alignment.center,
                      animation: "loading",
                      fit: BoxFit.contain,
                    ))),
                height10,
                (_txnController.response.value == "success")
                    ? Text("Transaction Completed", style: t16_Light)
                    : (_txnController.response.value == "error")
                    ? Text("Something went wrong or Probably server down", style: t16_Light, textAlign: TextAlign.center,)
                    : Text(
                  "Please Wait...Transaction is under Process",
                  style: t16_Light,
                  textAlign: TextAlign.center,
                )
              ],
            )),
      ),
    );
  }
}

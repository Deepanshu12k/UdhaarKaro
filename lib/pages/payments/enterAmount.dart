import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';

class EnterAmount extends StatefulWidget {
  @override
  _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  Map _data = {};
  TransactionController _txnController = Get.find(tag: "txn-controller");

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;

    _txnController.txnModel.value.amount = "";
    _txnController.txnModel.value.note = "";

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: backIconDark),
                ),
                height30,
                Avatar(
                  radius: 35,
                  networkImg: _txnController.txnModel.value.pic,
                ),
                height10,
                height10,
                Text(
                  (_data["type"] == 1) ? "Taking from" : "Giving to",
                  style: h4_Dark,
                ),
                Text(
                  _txnController.txnModel.value.name,
                  style: h3_Dark,
                ),
                height5,
                (_data["type"] == 1)
                    ? Text(
                        (_txnController.txnModel.value.limit != '0')
                            ? "Your transaction limit is Rs. ${_txnController.txnModel.value.limit}"
                            : "No Transaction limit",
                        style: t16_Dark,
                      )
                    : Text(""),
                height60,
                SizedBox(
                  width: 225,
                  child: TextFormField(
                    decoration: inputDecor2.copyWith(
                        labelText: "Rs.", labelStyle: t26_Dark),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(7)
                    ],
                    keyboardType: TextInputType.number,
                    style: h1_Dark,
                    onChanged: (val) {
                      _txnController.txnModel.value.amount = val;
                    },
                  ),
                ),
                height30,
                Container(
                  width: 220,
                  height: 80,
                  child: TextFormField(
                    style: t20_Dark,
                    maxLines: 4,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Add a Description",
                    ),
                    onChanged: (value) =>
                        _txnController.txnModel.value.note = value,
                  ),
                ),
                height30,
                height10,
                InkWell(
                    onTap: () {
                      if (_txnController.txnModel.value.amount == "") {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: new Text("Please enter some amount")));
                      } else {
                        if (_data["type"] == 1) {
                          if (_txnController.txnModel.value.limit != '0' &&
                              int.parse(_txnController.txnModel.value.amount) >
                              int.parse(_txnController.txnModel.value.limit)) {
                            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                content: new Text(
                                    "You can't enter the amount above specified limit")));
                          } else {
                            Navigate().toTakeAmountConfirmation(context, _data);
                          }
                        } else {
                          Navigate().toGiveAmountConfirmation(context, _data);
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          color: lightBlueColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: whiteColor,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

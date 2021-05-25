import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';
import 'package:intl/intl.dart';

class GivenAmountDetails extends StatelessWidget {

  Map data;
  final TransactionController _txnController = Get.find(tag: "txn-controller");

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                    color: lightOrangeColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: backIconDark
                        ),
                      ),
                      height30,
                      Center(
                        child: Avatar(
                          radius: 45,
                          networkImg: _txnController.txnModel.value.pic,
                        ),
                      ),
                      height10,
                      height10,
                      Text(
                        'Amount given to',
                        style: t20_Light,
                      ),
                      height5,
                      Text(
                        _txnController.txnModel.value.name,
                        style: h3_Light,
                      ),
                      height10,
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height10,
                      Text(
                        'Paid',
                        style: detailsHeadingTextStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            _txnController.txnModel.value.amount,
                            style: h2_Dark,
                          ),
                          Text(
                            'rs.',
                            style: t20_Dark,
                          ),
                        ],
                      ),
                      height30,
                      height10,
                      Text(
                          'Date',
                          style: detailsHeadingTextStyle
                      ),
                      Text(
                          DateFormat('d MMM y, H:m').format( DateTime.parse(_txnController.txnModel.value.date)),
                          style: t20_Dark
                      ),
                      height30,
                      height10,
                      Text(
                        'Transaction ID',
                        style: detailsHeadingTextStyle,
                      ),
                      Text(
                        _txnController.txnModel.value.transactionId,
                        style: t20_Dark,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

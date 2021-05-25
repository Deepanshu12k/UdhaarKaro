import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/apiCalls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class TransactionController extends GetxController {
  UserController _userController = Get.find(tag: "user-controller");
  var txnModel = TransactionModel().obs;
  var load = 0.obs;
  var response = "".obs;
  Random random = new Random();

  Future addTransaction(type) async {
    try {
      txnModel.value.transactionId =
          (random.nextInt(99999999) + 100000).toString();
      txnModel.value.date = DateTime.now().toString();
      txnModel.value.status = "pending";
      txnModel.value.limit = "";
      (type == 1)
          ? txnModel.value.toId = _userController.userModel.value.id
          : txnModel.value.fromId = _userController.userModel.value.id;
      await TransactionApiCall().addTxn(txnModel.value).then((value) {
        response.value = value;
      });
    } finally {}
  }

  Future getAnotherUserData(type) async {
    load.value = 1;
    try {
      var value;
      (type == 1)
          ? value = await TransactionApiCall().checkUserWithLimit(
              _userController.userModel.value.id, txnModel.value.number)
          : value = await TransactionApiCall().checkUserNumber(
              _userController.userModel.value.id, txnModel.value.number);

      response.value = value;
      if (response.value != "no data" &&
          response.value != "limit exceeded" &&
          response.value != "error") {
        var res = jsonDecode(response.value);
        (type == 1)
            ? txnModel.value.fromId = res["id"]
            : txnModel.value.toId = res["id"];
        txnModel.value.name = res["name"];
        txnModel.value.pic = res["pic"];
        txnModel.value.limit = res["limit_value"] ?? '0';
      }
    } finally {
      load.value = 0;
    }
  }
}

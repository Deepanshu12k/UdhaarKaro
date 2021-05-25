import 'dart:async';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/apiCalls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class GetAllTransactionController extends GetxController {
  UserController _userController = Get.find(tag: "user-controller");
  var txn = List<TransactionModel>.empty(growable: true).obs;
  var load = 1.obs;


  @override
  void onInit() {
    super.onInit();
    load.value = 1;
  }

  Future<dynamic> allTransactionData(String id) async {
    try{
    await TransactionApiCall().getAllTxn(id).then((value) {
        if (value != "error") {
          txn.assignAll(value);
        }
        else{
          //Alert().failFlutterToast("Something went wrong or Probably server down!");
        }
      });
    }
    finally {
      if(_userController.login.value == true){
        load.value = 0;
        allTransactionData(id);
      }
    }
  }
}

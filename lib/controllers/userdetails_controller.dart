import 'package:get/get.dart';
import 'package:udhaarkaroapp/apiCalls/transaction.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/transaction_model.dart';

class UserDetailsController extends GetxController{
  UserController _userController = Get.find(tag: "user-controller");
  var userTxn = List<TransactionModel>.empty(growable: true).obs;
  var sortedUserTxn = List<TransactionModel>.empty(growable: true).obs;
  var yourId = "".obs;
  var cType = "All";
  var date = "2000-01-01";
  var load = 1.obs;
  var count = 0;


  @override
  void onInit() {
    super.onInit();
    load.value = 1;
  }

  Future getUserTxn() async {
    count++;
    try{
      await TransactionApiCall().getUserTransactions(_userController.userModel.value.id, yourId.value).then((value) {
        if (value != "error") {
          userTxn.assignAll(value);
        }
        else{
          //Alert().failFlutterToast("Something went wrong or Probably server down!");
        }
      });
    }
    finally {
      if(count == 1){getSortedList();}
    }
  }


  void getSortedList(){
    sortedUserTxn.clear();
    load.value = 1;
    try {
      if (cType == "All") {
        userTxn.forEach((element) {
          if (DateTime.parse(element.date).isAfter(
              DateTime.parse(date))) {
            sortedUserTxn.add(element);
          }
        });
      }
      else if (cType == "Sent") {
        userTxn.forEach((element) {
          if (element.fromId == _userController.userModel.value.id) {
            if (DateTime.parse(element.date).isAfter(
                DateTime.parse(date))) {
              sortedUserTxn.add(element);
            }
          }
        });
      }
      else {
        userTxn.forEach((element) {
          if (element.toId == _userController.userModel.value.id &&
              DateTime.parse(element.date).isAfter(
                  DateTime.parse(date))) {
            sortedUserTxn.add(element);
          }
        });
      }
    }
    finally{
      load.value = 0;
    }

  }
}
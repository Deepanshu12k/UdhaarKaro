import 'dart:async';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/models/userlist_model.dart';
import 'package:udhaarkaroapp/apiCalls/user.dart';

class UserListController extends GetxController {
  final userList = List<UserListModel>.empty(growable: true).obs;
  UserController _userController = Get.find(tag: "user-controller");
  var load = 1.obs;
  var updateLoad = 0.obs;
  var response = "".obs;

  @override
  void onInit() {
    super.onInit();
    load.value = 1;
  }

  Future getUserData(String id) async {
    try {
      await UserApiCalls().getUsersList(id).then((value) {
        if (value != "error") {
          userList.clear();
          userList.assignAll(value);
        }
        else{
          //Alert().failFlutterToast("Something went wrong or Probably server down!");
        }
      });
    }
    finally {
      if(_userController.login.value == true){
        load.value = 0;
        getUserData(id);
      }
    }
  }

  Future insertUserLimit(String fromId, String toId, String amount, String action) async {
    updateLoad.value = 1;
    try {
      await UserApiCalls().setUsersLimit(fromId, toId, amount, action).then((value) {
      response.value = value;
      });
    }
    finally {
      updateLoad.value = 0;
    }
  }
}

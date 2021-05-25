import 'dart:convert';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/apiCalls/user.dart';
import 'package:udhaarkaroapp/models/user_model.dart';

class UserController extends GetxController {
  var userModel = UserModel().obs;
  var load = 0.obs;
  var response = "".obs;
  var login = false.obs;

  Future logIn() async {
    try {
      load.value = 1;
      userModel.value.lastLoginAt = DateTime.now().toString();
      await UserApiCalls().logIn(userModel.value).then((value) {
        response.value = value;
        if (response.value != "no data" && response.value != "error") {
            var res = jsonDecode(response.value);
            userModel.value.id = res["id"];
            userModel.value.pic = res["pic"];
            userModel.value.name = res["name"];
            userModel.value.email = res["email"];
            userModel.value.accountType = res["account_type"];
            login.value = true;
          }
      });
    } finally {
      load.value = 0;
    }
  }

  Future signUp() async {
    try {
      load.value = 1;
      userModel.value.businessMainCategory = "yes";
      userModel.value.businessSubCategory = "no";
      userModel.value.createdAt = DateTime.now().toString();
      userModel.value.updatedAt = DateTime.now().toString();
      userModel.value.lastLoginAt = DateTime.now().toString();
      userModel.value.status = "success";

      await UserApiCalls().addUser(userModel.value).then((value) {
        response.value = value;
        if (response.value != "exists" && response.value != "error") {
            var res = jsonDecode(response.value);
            userModel.value.id = res["id"];
            userModel.value.pic = res["pic"];
            login.value = true;
          }
      });
    } finally {
      load.value = 0;
    }
  }

  Future updateUser() async {
    try {
      load.value = 1;
      userModel.value.updatedAt = DateTime.now().toString();
      await UserApiCalls().update(userModel.value).then((value) {
        response.value = value;
      });
    } finally {
      load.value = 0;
    }
  }

  Future updateUserImage() async {
    try {
      await UserApiCalls().updateImage(userModel.value).then((value) {
        response.value = value;
      });
    } finally {}
  }

  Future updateUserPass() async {
    load.value = 1;
    try {
      await UserApiCalls().updatePass(userModel.value).then((value) {
        response.value = value;
      });
    } finally {
      load.value = 0;
    }
  }

  Future checkUser() async {
    load.value = 1;
    try {
      await UserApiCalls().checkUserData(userModel.value).then((value) {
        response.value = value;
      });
    } finally {
      load.value = 0;
    }
  }
}

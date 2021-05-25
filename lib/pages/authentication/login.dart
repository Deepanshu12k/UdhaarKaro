import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _userController = Get.put(UserController(), tag: "user-controller");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 45),
                    ),
                    // height5,
                    Text(
                      ' Log in to continue!',
                      style: h4_Dark,
                    ),
                    height60,
                    Container(
                      decoration: rectDecoration,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PhoneTextField(
                              decoration: inputDecor2.copyWith(
                                  labelText: "Phone Number",
                                  labelStyle: t16_Dark),
                              callback: (value) {
                                _userController.userModel.value.mobileNumber = value;
                              },
                            ),
                            height10,
                            height10,
                            PasswordTextField(
                              decoration: inputDecor2.copyWith(
                                  labelText: "Password", labelStyle: t16_Dark),
                              callback: (value) {
                                _userController.userModel.value.password = value;
                              },
                            ),
                            height5,
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  onTap: () {
                                    Navigate().toForgotPassword(context);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: t14_Dark,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height30,
                    Center(
                      child: SubmitButton(
                        text: "Login",
                        width: 150,
                        height: 40,
                        color: lightBlueColor,
                        formKey: _formKey,
                        callback: ()  async {
                          await _userController.logIn();
                          if (_userController.response.value == "no data") {
                            Alert().failSweetAlert(
                                "Wrong Phone number or Password", context);
                          }
                          else if (_userController.response.value == "error"){
                            Alert().failSweetAlert(
                                "Something went wrong or Probably server down",
                                context);
                          }
                          else{
                            Navigate().toMainScreen(context);
                          }
                        },
                      ),
                    ),
                    height60,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        width5,
                        InkWell(
                          onTap: () {
                            Navigate().toSignUp(context);
                          },
                          child: Text(
                            " Sign-Up",
                            style: TextStyle(fontSize: 19, color: blueColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() =>
              Center(child: CircularLoader(load: _userController.load.value))
          )
        ],
      ),
    );
  }
}

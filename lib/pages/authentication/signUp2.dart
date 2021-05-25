import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/services/smsServices.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';
import 'dart:math';

class SignUp2 extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp2> {

  final _formKey = GlobalKey<FormState>();
  String _pass, _cpass;
  Random random = new Random();
  UserController _userController = Get.find(tag: "user-controller");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Create Account,',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 35),
                    ),
                    // height5,
                    Text(
                      'Sign Up to get started!',
                      style: h4_Dark,
                    ),

                    height60,
                    Text('Set-up your Authentication', style: t18_Dark,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: rectDecoration,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            PhoneTextField(
                              decoration: inputDecor2,
                              label: "Phone Number",
                              callback: (value) {
                                _userController.userModel.value.mobileNumber = value;
                              },
                            ),

                            height10,
                            PasswordTextField(
                              decoration: inputDecor2,
                              label: "Password",
                              callback: (value) {
                                _userController.userModel.value.password = value;
                                _pass = value;
                              },
                            ),

                            height10,

                            PasswordTextField(
                              decoration: inputDecor2,
                              label: "Confirm Password",
                              callback: (value) {
                                _cpass = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    height30,
                    Center(
                        child: SubmitButton(
                            text: "Sign Up",
                            width: 200,
                            height: 50,
                            elevation: 0,
                            color: lightBlueColor,
                            formKey: _formKey,
                            callback: () {
                              if (_pass == _cpass) {
                                var otp = (random.nextInt(900000) + 100000).toString();
                                SMS().sendSms(_userController.userModel.value.mobileNumber, otp);
                                Navigate().toVerification(context, {"otp": otp});
                              }
                              else {
                                Fluttertoast.showToast(
                                    msg: "Confirm Password dont match with Password field",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
                        )
                    )
                  ]
              ),
            ),
          )
          ,
        )
    );
  }
}




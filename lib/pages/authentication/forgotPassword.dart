import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/services/smsServices.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  UserController _userController = Get.find(tag: "user-controller");
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      child: backIconDark,
                      onTap: (){
                        Navigator.pop(context);
                      },
                    )
                  ),

                    Icon(MdiIcons.lockQuestion,color: Color(0xFF41C8F3),size: 250,
                    ),
                    height30,
                    Text(
                      'Forgot Password?',
                      style: h3_Dark,
                    ),
                    height10,
                    Text("Enter your Registered mobile number so that we can send OTP to reset your password",
                      style: t18_Dark,
                      textAlign: TextAlign.center,),
                    height30,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PhoneTextField(
                              label: "Phone Number",
                              decoration: inputDecor2,
                              callback: (value){
                              _userController.userModel.value.mobileNumber = value;
                              },
                            ),
                            height30,
                            SubmitButton(
                              text: "Continue",
                              width: 140,
                              height: 50,
                              elevation: 10,
                              color: lightBlueColor,
                              formKey: _formKey,
                              callback: () async {
                                await _userController.checkUser();
                                if(_userController.response.value == "no data"){
                                  Alert().failFlutterToast("This Number is not registered");
                                }
                                else if(_userController.response.value == "error"){
                                  Alert().failSweetAlert(
                                      "Something went wrong or Probably server down",
                                      context);
                                }
                                else{
                                  var otp = (random.nextInt(900000) + 100000).toString();
                                  SMS().sendSms(_userController.userModel.value.mobileNumber, otp);
                                  Navigate().toNewPassword(context, {"otp": otp});
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

              ),
            ),

            Obx(() => Center(child: CircularLoader(load: _userController.load.value)))
          ],
        ),
      ),
    );
  }
}

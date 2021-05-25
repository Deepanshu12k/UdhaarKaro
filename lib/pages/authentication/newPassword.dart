import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/services/smsServices.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  UserController _userController = Get.find(tag: "user-controller");
  String _otp, _pass, _cpass;
  String pin;
  Map data = {};
  Random random = new Random();
  BasicController _basicController = Get.find(tag: "basic-control");


  @override
  void initState() {
    super.initState();
    _basicController.time.value = 30;
    _basicController.resendVisible.value = true;
    _basicController.timerStatus.value= true;
    _basicController.startTimer();
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    pin = data["otp"];

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
                            onTap: () {
                              _basicController.timerStatus.value = false;
                              Navigator.pop(context);
                            },
                          )),
                      height30,
                      Text('Create a new Password', style: h3_Dark),
                      height30,
                      Text(
                        "Please enter the OTP that will be send to your mobile number",
                        style: t16_Dark,
                        textAlign: TextAlign.center,
                      ),
                      height30,
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: rectDecoration,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OTPTextField(
                                decoration: inputDecor2,
                                label: "OTP",
                                callback: (val) {
                                  _otp = val;
                                },
                              ),
                              height10,
                              PasswordTextField(
                                  decoration: inputDecor2.copyWith(
                                      labelText: "Enter new Password",
                                      labelStyle: t16_Dark),
                                  callback: (value) {
                                    _userController.userModel.value.password =
                                        value;
                                    _pass = value;
                                  }),
                              height10,
                              PasswordTextField(
                                decoration: inputDecor2.copyWith(
                                    labelText: "ReEnter new Password",
                                    labelStyle: t16_Dark),
                                callback: (value) {
                                  _cpass = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "didn't receive code?",
                            style: TextStyle(
                              color: black38,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Obx(() => AbsorbPointer(
                            absorbing: _basicController.resendVisible.value,
                            child: TextButton(
                              onPressed: () {
                                _basicController.time.value = 30;
                                _basicController.resendVisible.value = true;
                                _basicController.startTimer();
                                pin = (random.nextInt(900000) + 100000).toString();
                                SMS().sendSms(_userController.userModel.value.mobileNumber, pin);
                              },
                              child: Text(" Resend",
                                  style: TextStyle(fontSize: 18, color: redColor)),
                            ),
                          )),
                          width5,
                          Obx(() => Text(_basicController.time.value.toString() + " Sec", style: t18_Dark))
                        ],
                      ),
                      height10,
                      height10,
                      SubmitButton(
                        text: "Reset Password",
                        width: 200,
                        height: 50,
                        elevation: 10,
                        color: lightBlueColor,
                        formKey: _formKey,
                        callback: () async {
                          if (_otp == pin) {
                            if (_pass == _cpass) {
                              await _userController.updateUserPass();
                              if (_userController.response.value == "1") {
                                _basicController.timerStatus.value = false;
                                Alert().successSweetAlert(
                                    "Password Updated", context, () =>
                                    Navigate().toLogin(context));
                              }
                              else {
                                Alert().failSweetAlert(
                                    "Something went wrong or Probably server down",
                                    context);
                              }
                            }
                            else {
                              Alert().failFlutterToast(
                                  "Re-Entered Password dont match with Password field");
                            }
                          }
                          else {
                            Alert().failFlutterToast("Wrong otp entered");
                          }
                        }
                      ),
                    ]),
              ),
            ),
            Obx(() => Center(child: CircularLoader(load: _userController.load.value)))
          ],
        ),
      ),
    );
  }
}

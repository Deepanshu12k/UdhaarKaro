import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/basic_controller.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/services/smsServices.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  UserController _userController = Get.find(tag: "user-controller");
  BasicController _basicController = Get.find(tag: "basic-control");
  int pin;
  Map data = {};
  Random random = new Random();

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

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
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
                    Text(
                      'Verification',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                    ),
                    height60,
                    height30,
                    Text(
                      "Enter the verification code we have sent you on your mobile number.",
                      style: t18_Dark,
                      textAlign: TextAlign.center,
                    ),
                    height30,
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: greyColor,
                      fillColor: redColor,
                      enabledBorderColor: greyColor,
                      disabledBorderColor: greyColor,
                      focusedBorderColor: redColor,
                      cursorColor: blackColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) async {
                        if (data["otp"] == verificationCode) {
                          await _userController.signUp();
                          if (_userController.response.value == "exists") {
                            _basicController.timerStatus.value = false;
                            Alert().warningSweetAlert(
                                "Profile already exists with this number... Try to login",
                                context,
                                    () => Navigate().toLogin(context));
                          } else if (_userController.response.value ==
                              "error") {
                            Alert().failSweetAlert(
                                "Something went wrong or Probably server down",
                                context);
                          } else {
                            _basicController.timerStatus.value = false;
                            Alert().successSweetAlert(
                                "Profile Created", context,
                                    () => Navigate().toMainScreen(context));
                          }
                        }
                        else{
                         Alert().failFlutterToast("Wrong otp entered");
                        }
                      }
                    ),
                    height30,
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
                              var otp = (random.nextInt(900000) + 100000).toString();
                              SMS().sendSms(_userController.userModel.value.mobileNumber, otp);
                            },
                            child: Text(" Resend",
                                style: TextStyle(fontSize: 18, color: redColor)),
                          ),
                        )),
                        width5,
                        Obx(() => Text(_basicController.time.value.toString() + " Sec", style: t18_Dark))
                      ],
                    ),
                    height30,
                  ],
                ),
              ),
            ),
          ),
          Obx(() =>
              Center(child: CircularLoader(load: _userController.load.value)))
        ],
      ),
    );
  }
}

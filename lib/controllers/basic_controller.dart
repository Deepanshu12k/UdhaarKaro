import 'dart:async';

import 'package:get/get.dart';

class BasicController extends GetxController {

  //for password textField
  final obscureText = true.obs;

  void passToggle() => obscureText.value = !obscureText.value;


  //for qrCode scanner message
  final status = true.obs;
  final msg = "Place the QR code inside Scanner Area".obs;
  void flashToggle() => status.value = !status.value;



  //for userDetail page animations
  final typeIndex = 2.obs;
  final durationIndex = 4.obs;
  final typeAnimatedHeight = 0.0.obs;
  final durationAnimatedHeight = 0.0.obs;

  void changeType(val) => typeIndex.value = val;

  void changeDuration(val) => durationIndex.value = val;

  void typeAnimateTile() => typeAnimatedHeight.value != 0.0
      ? typeAnimatedHeight.value = 0.0
      : typeAnimatedHeight.value = 60.0;

  void durationAnimateTile() => durationAnimatedHeight.value != 0.0
      ? durationAnimatedHeight.value = 0.0
      : durationAnimatedHeight.value = 60.0;


  //for resend otp timer
  Timer _timer;
  final time = 30.obs;
  final resendVisible = true.obs;
  final timerStatus = true.obs;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec,
          (Timer timer) {
      if(timerStatus.value) {
        if (time.value == 0) {
          resendVisible.value = false;
          timer.cancel();
        } else {
          time.value--;
        }
      }
      else{
        timer.cancel();
      }
      },
    );
  }

}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';

class Alert{


  void successFlutterToast(String value){
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: greenColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void failFlutterToast(String value){
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: redColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void successSweetAlert(String sTitle, context, callback()){
    SweetAlert.show(context, title: "Success",
        subtitle: sTitle,
        style: SweetAlertStyle.success,
        confirmButtonColor: darkBlueColor,
        onPress: (bool isConfirm){
         if(isConfirm){
         callback();
         }
         return false;
         }
    );
  }

  void failSweetAlert(String sTitle, context){
    SweetAlert.show(context, title: "Failed",
        subtitle: sTitle,
        style: SweetAlertStyle.error,
      confirmButtonColor: darkBlueColor,
    );
  }

  void warningSweetAlert(String sTitle, context, callback){
    SweetAlert.show(context, title: "Alert",
        subtitle: sTitle,
        style: SweetAlertStyle.confirm,
        confirmButtonColor: darkBlueColor,
        onPress: (bool isConfirm){
          if(isConfirm){
           callback();
          }
          return false;
        }
    );
  }
}
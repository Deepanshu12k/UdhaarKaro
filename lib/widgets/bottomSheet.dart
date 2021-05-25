import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class UsersBottomSheet extends StatefulWidget {

  String amount, toId, fromId;

  UsersBottomSheet({this.amount, this.toId, this.fromId});

  @override
  _UsersBottomSheetState createState() => _UsersBottomSheetState();
}

class _UsersBottomSheetState extends State<UsersBottomSheet> {

  final _formKey = GlobalKey<FormState>();
  var amt;
  var action;
  UserListController _userListController = Get.find(tag: "user_list");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          height10,
          Text(
            "Update Transaction Limit",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          height30,

          Form(
            key: _formKey,
            child:  TransactionTextField(
              value: widget.amount ?? '0',
              label: "Amount",
              decoration: inputDecor2,
              callback: (val) {
                 amt = val;
              },
            ),
          ),
          height30,
          SubmitButton(
            text: "Update",
            width: 150,
            height: 40,
            color: lightBlueColor,
            formKey: _formKey,
            callback: ()  async {
              Navigator.pop(context);
               if(widget.amount != null && amt != '0'){
                 action = "update";
               }
               else if(widget.amount != null && amt == '0'){
                 action  = "delete";
               }
               else{
                 action = "insert";
               }
             await _userListController.insertUserLimit(widget.fromId, widget.toId, amt, action);
             if(_userListController.response.value == "error"){
               Alert().failFlutterToast("Something went wrong... try again later");
             }
             else{
              Alert().successFlutterToast("Transaction limit updated");
             }
            },
          ),
        ],
      ),
    );
  }
}


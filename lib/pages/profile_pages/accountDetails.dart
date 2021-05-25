import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/alerts.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  UserController _userController = Get.find(tag: "user-controller");

  var _pic, _email, _category, _pass;
  final _formKey = GlobalKey<FormState>();


  _imgFromGallery() async {
    final picker = ImagePicker();
    dynamic image = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

      if (image != null) {
          _pic = File(image.path);
        _userController.userModel.value.pic = base64Encode(_pic.readAsBytesSync());
        await _userController.updateUserImage();
        if(_userController.response.value == "updated") {
          Alert().successFlutterToast("Image Updated");
        }
        else{
          Alert().failFlutterToast("Something went wrong or Probably server down!");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    _email =_userController.userModel.value.email;
    _category = _userController.userModel.value.accountType;
    _pass = _userController.userModel.value.password;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      decoration: BoxDecoration(
                        color: darkBlueColor,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: backIconLight),
                          ),
                          height10,
                          Center(
                               child: Stack(
                                 alignment: AlignmentDirectional.bottomEnd,
                                 children: [
                                   Avatar(
                                     networkImg: _userController.userModel.value.pic,
                                     radius: 60,
                                   ),
                                   InkWell(
                                     onTap: () => _imgFromGallery(),
                                     child: Container(
                                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(50),
                                           color: whiteColor,
                                         ),child: Icon(Icons.edit, color: blueColor, size: 20,)),
                                   ),
                                 ],)
                         ),
                          height10,
                          Center(
                              child: Text(
                            _userController.userModel.value.name,
                            style: h2_Light,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PhoneTextField(
                              value:  _userController.userModel.value.mobileNumber,
                              decoration: inputDecor,
                              label: "Phone Number",
                              enabled: false,
                              callback: (value) {},
                            ),
                            height10,
                            EmailTextField(
                              value: _email,
                              decoration: inputDecor,
                              label: "Email",
                              callback: (value) {
                                _email = value;
                              },
                            ),
                            height10,
                            height10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category", style: t14_Dark),
                                DropDown(
                                  items: ["Personal Account", "Business Account"],
                                  initialValue: _category,
                                  onChanged: (val) {
                                    _category = val;
                                  },
                                  isExpanded: true,
                                ),
                              ],
                            ),
                            height10,
                            PasswordTextField(
                              value: _pass,
                              decoration: inputDecor,
                              label: "Password",
                              callback: (value) {
                                _pass = value;
                              },
                            ),
                            height30,
                            Center(
                                child: SubmitButton(
                              text: "Save",
                              width: 300,
                              height: 50,
                              elevation: 0,
                              color: darkBlueColor,
                              formKey: _formKey,
                              callback: () async {
                                _userController.userModel.value.email = _email;
                                _userController.userModel.value.accountType = _category;
                                _userController.userModel.value.password = _pass;
                                await _userController.updateUser();
                                if(_userController.response.value == "Data Updated"){
                                  Alert().successFlutterToast(_userController.response.value);
                                }
                                else{
                                  Alert().failFlutterToast("Something went wrong or Probably server down!");
                                }
                              },
                            ))
                          ],
                        ),
                      ),
                    )
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

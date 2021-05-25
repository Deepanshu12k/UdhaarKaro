import 'dart:convert';
import 'dart:io';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';
import 'package:udhaarkaroapp/widgets/textInputField.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String _category;
  File _image1;

  UserController _userController = Get.find(tag: "user-controller");

  _imgFromGallery() async {
    final picker = ImagePicker();
    dynamic image = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image1 = File(image.path);
        _userController.userModel.value.pic = base64Encode(_image1.readAsBytesSync());
      } else {
        _userController.userModel.value.pic = "";
      }
    });
  }

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
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                ),

                Text(
                  'Sign Up to get started!',
                  style: h4_Dark,
                ),
                height60,
                Text('Enter your personal details', style: t18_Dark,),
                height10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: rectDecoration,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Avatar(
                              galleryImg: (_image1 == null) ? "" : _image1,
                              radius: 65,
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
                          ],
                        ),
                        height10,
                        NameTextField(
                          decoration: inputDecor2,
                          label: "Full Name",
                          callback: (value){
                            _userController.userModel.value.name = value;
                          },
                        ),

                        height10,
                        EmailTextField(
                          decoration: inputDecor2,
                          label: "Email",
                          callback: (value){
                            _userController.userModel.value.email = value;
                          },
                        ),
                        height10,
                        DropDown(
                          items: ["Personal Account", "Business Account"],
                          hint: Text("Select Category", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                          onChanged: (val) {
                            _userController.userModel.value.accountType = val;
                            _category = val;
                          },
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ),
                ),
                height10,
                height10,
               Center(
                 child: SubmitButton(formKey: _formKey,
                         callback: (){
                       if(_category != null) {
                         Navigate().toSignUp2(context, {"pic" : _image1, "category" : _category});
                       }
                       else{
                         Fluttertoast.showToast(
                             msg: "Please select your category",
                             toastLength: Toast
                                 .LENGTH_SHORT,
                             gravity: ToastGravity.BOTTOM,
                             backgroundColor: Colors.red,
                             textColor: Colors.white,
                             fontSize: 17);
                       }
                     },
                       text: "Next",
                       width: 100,
                       height: 40,
                       color: lightBlueColor,
                 ),
               ),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    InkWell(
                        onTap: (){
                          Navigate().toLogin(context);
                        },
                        child: Text(" Login", style: TextStyle(fontSize: 18, color: redColor),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




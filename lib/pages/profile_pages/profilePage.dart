import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';
import 'package:udhaarkaroapp/controllers/user_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  final UserController _userController = Get.find(tag: "user-controller");
  final GetAllTransactionController _allTxnController = Get.find(tag: "all-txn");
  final UserListController _userListController = Get.find(tag: "user_list");
  final GetTakenTransactionController _takenTransactionController = Get.find(tag: "taken-txn");
  final GetGivenTransactionController _givenTransactionController = Get.find(tag: "given-txn");


  void controllersReset(){
    _userController.login.value = false;
    _allTxnController.load.value = 1;
    _userListController.load.value = 1;
    _takenTransactionController.load.value = 1;
    _givenTransactionController.load.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: darkBlueColor,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () => Navigate().toQRCode(context),
                          child: Icon(Icons.qr_code, color: whiteColor,)),
                    ),
                    Center(
                        child: Avatar(
                          radius: 50,
                          networkImg: _userController.userModel.value.pic,
                        )),
                    height10,
                    Center(
                        child: Text(
                          _userController.userModel.value.name,
                      style: h2_Light,
                    ))
                  ],
                ),
              ),
              height10,
              height10,
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profile Details",
                                style: t22_Dark,
                              ),
                              profilePageIcon
                            ],
                          ),
                          onTap: () {
                            Navigate().toAccountDetails(context);
                          },
                        ),
                        height30,
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/privacypolicy");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Privacy Policy",
                                style: t22_Dark,
                              ),
                              profilePageIcon
                            ],
                          ),
                        ),
                        height30,
                        InkWell(
                          onTap: () {
                            Navigate().toFeedback(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "FeedBackForm",
                                style: t22_Dark,
                              ),
                              profilePageIcon
                            ],
                          ),
                        ),
                        height30,
                        InkWell(
                          onTap: () {
                            Navigate().toUserList(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Users List",
                                style: t22_Dark,
                              ),
                              profilePageIcon
                            ],
                          ),
                        ),
                        height30,
                        InkWell(
                          onTap: () {
                            Navigate().toAboutUs(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "About Us",
                                style: t22_Dark,
                              ),
                              profilePageIcon,
                            ],
                          ),
                        ),
                        height10,
                        height5,
                        divider,
                        height10,
                        height5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Text(
                                "Logout",
                                style: TextStyle(fontSize: 22, color: redColor),
                              ),
                              onTap: (){
                                controllersReset();
                               Navigate().toLogin(context);
                              },
                            ),
                            Icon(MdiIcons.logout)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/card.dart';
import 'package:udhaarkaroapp/widgets/emptyscreen.dart';
import 'package:udhaarkaroapp/widgets/headers.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  UserController _userController = Get.find(tag: "user-controller");
  GetAllTransactionController _allTxnController = Get.find(tag: "all-txn");

  @override
  void initState() {
    super.initState();
    if(_allTxnController.load.value == 1){
    _allTxnController.allTransactionData(_userController.userModel.value.id);}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          child: Column(
            children: [
              Header(text: "Notifications", backIcon: false),
              Flexible(
                  child: Obx(() {
                        if(_allTxnController.load.value == 0) {
                          if(_allTxnController.txn.length > 0){
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _allTxnController.txn.length,
                                itemBuilder: (context, index) {
                                  return NotificationCard(
                                    str: _allTxnController,
                                    itemIndex: index,
                                  );
                                });
                          }
                          else{
                            return EmptyScreen(
                              text: "OOPS! No Transactions found",
                            );
                          }
                        }
                        else{
                          return Center(child: FoldingCubeLoader(
                            load: 1,
                            bgContainer: false,
                            color: darkBlueColor,));
                        }
                      }
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

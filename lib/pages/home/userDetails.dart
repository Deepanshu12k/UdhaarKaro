import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/TransactionOperation.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/card.dart';
import 'package:udhaarkaroapp/widgets/circularAvatar.dart';
import 'package:udhaarkaroapp/widgets/emptyscreen.dart';
import 'package:udhaarkaroapp/widgets/expandableContainer.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  Map _data = {};
  UserDetailsController userTxnController = Get.find(tag: "userdetail-txn");
  final TransactionController _txnController = Get.find(tag: "txn-controller");


  @override
  void initState() {
    super.initState();
    userTxnController.load.value = 1;
    userTxnController.count = 0;
    userTxnController.cType = "All";
    userTxnController.date = "2000-01-01";
    userTxnController.getUserTxn();
  }
  @override
  Widget build(BuildContext context) {

    _data = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                        height5,
                        Center(
                            child: Avatar(
                          radius: 40,
                              networkImg: _data["pic"],
                        )),
                        height10,
                        Center(
                            child: Text(
                          _data["name"],
                          style: h3_Light,
                        )),
                        height10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (_data["type"] == 1) ? "Has to gave Rs. " : "Has to take Rs. ",
                              style: t16_Light,
                            ),
                            Text(_data["amount"], style: t18_Light,)
                          ],
                        ),
                      ],
                    ),
                  ),
                  ExpandableContainer(callback: (value){
                    //setState(() => _index = value);
                  },),
                  Flexible(
                    child: Container(
                      color: whiteColor,
                      child: Obx (() {
                        if (userTxnController.load.value == 0) {
                          if (userTxnController.sortedUserTxn.length > 0) {
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: userTxnController.sortedUserTxn.length,
                                itemBuilder: (context, index) {
                                  return UserDetailCard(
                                    str: userTxnController,
                                    itemIndex: index,
                                  );
                                });
                          }
                          else {
                            return EmptyScreen(
                              text: "OOPS! No Transactions found",
                            );
                          }
                        }
                        else {
                          return Center(child: FoldingCubeLoader(
                            load: 1,
                            bgContainer: false,
                            color: darkBlueColor,));
                        }
                      })
                    ),
                  )
                ],
              ),
            ),
            Obx(() =>
                Center(child: CircularLoader(load: _txnController.load.value)))
          ],
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            (_data["type"] != 1) ?
            TakeFloatingButton(
              callback: () async {
                _txnController.txnModel.value.number = userTxnController.sortedUserTxn[0].number;
                await TxnOperation().operation(context, {"type" : 1});
                //Navigate().toEnterAmount(context, {"type" : 1});
              },
            ) : width1,
            GaveFloatingButton(
              callback: () async {
                _txnController.txnModel.value.number = userTxnController.sortedUserTxn[0].number;
                await TxnOperation().operation(context, {"type" : 2});
                //Navigate().toEnterAmount(context, {"type" : 2});
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}

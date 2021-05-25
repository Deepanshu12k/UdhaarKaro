import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';
import 'package:udhaarkaroapp/widgets/card.dart';
import 'package:udhaarkaroapp/widgets/emptyscreen.dart';
import 'package:udhaarkaroapp/widgets/headers.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int data = 1;
  GetTakenTransactionController takenTxnController = Get.find(tag: "taken-txn");
  GetGivenTransactionController givenTxnController = Get.find(tag: "given-txn");
  UserDetailsController userTxnController = Get.find(tag: "userdetail-txn");


  @override
  void initState() {
    super.initState();
    if(takenTxnController.load.value == 1 && givenTxnController.load.value == 1) {
      takenTxnController.getTakenTransactionData();
      givenTxnController.getGivenTransactionData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: lightGreyColor,
          appBar: AppBar(
            toolbarHeight: 220,
            flexibleSpace: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "UDHAAR KARO",
                        style: h3_Dark,
                      ),
                      Container()
                    ],
                  ),
                  height10,
                  height10,
                ],
              ),
            ),
            bottom: TabBar(
              tabs: [
                Obx(() => HomePageTabBarButton(
                        color: lightBlueColor,
                        icon: downArrowWhiteIcon,
                        price: "2500",
                        subtitle: "to take",
                        buttonText: "Taken",
                        count: takenTxnController.txn.length)
                ),
                Obx (() => HomePageTabBarButton(
                      color: lightOrangeColor,
                      icon: upArrowWhiteIcon,
                      price: "1200",
                      subtitle: "to gave",
                      buttonText: "Given",
                      count: givenTxnController.txn.length)
                ),
              ],
              indicatorColor: redColor,
            ),
          ),
          body: TabBarView(children: [
            Obx(() {
              if(takenTxnController.load.value == 0) {
              if (takenTxnController.txn.length > 0) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: takenTxnController.txn.length,
                    itemBuilder: (context, index) {
                      return HomeCard(
                        type: 1,
                        str: takenTxnController,
                        itemIndex: index,
                      );
                    });
              }
              else {
                return EmptyScreen(
                  text: "OOPS! No Taken Transactions found",
                );
              }
            }
            else {
              return Center(child: FoldingCubeLoader(
                load: 1,
                bgContainer: false,
                color: lightBlueColor,));
            }
            }),
            Obx(() {
              if(givenTxnController.load.value == 0) {
                if (givenTxnController.txn.length > 0) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: givenTxnController.txn.length,
                      itemBuilder: (context, index) {
                        return HomeCard(
                          type: 2,
                          str: givenTxnController,
                          itemIndex: index,
                        );
                      });
                }
                else {
                  return EmptyScreen(
                    text: "OOPS! No Given Transactions found",
                  );
                }
              }
              else {
                return Center(child: FoldingCubeLoader(
                  load: 1,
                  bgContainer: false,
                  color: lightOrangeColor,));
              }
            }),
          ]),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TakeFloatingButton(
                callback: () {
                  Navigate().toQRScanner(context, {"type": 1});
                },
              ),
              GaveFloatingButton(
                callback: () {
                  Navigate().toQRScanner(context, {"type": 2});
                },
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        ),
      ),
    );
  }
}

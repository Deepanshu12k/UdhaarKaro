import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/basic_controller.dart';
import 'package:udhaarkaroapp/controllers/userdetails_controller.dart';
import 'package:udhaarkaroapp/widgets/buttons.dart';

class ExpandableContainer extends StatefulWidget {
  final Function callback;

  ExpandableContainer({@required this.callback});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  DateTime now = DateTime.now();
  UserDetailsController userTxnController = Get.find(tag: "userdetail-txn");
  final BasicController _basicController = Get.find(tag: "basic-control");


  @override
  void initState() {
    super.initState();
    _basicController.typeIndex.value = 2;
    _basicController.durationIndex.value = 4;
    _basicController.typeAnimatedHeight.value = 0.0;
    _basicController.durationAnimatedHeight.value = 0.0;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          color: darkBlueColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => InkWell(
                onTap: () => _basicController.typeAnimateTile(),
                child: Row(
                  children: [
                    Text(
                      "Select Type:",
                      style: t14_Light,
                    ),
                    Icon(
                      ((_basicController.typeAnimatedHeight.value == 0.0)
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up),
                      color: whiteColor,
                    )
                  ],
                ),
              )),

              Obx(() => InkWell(
                onTap: () => _basicController.durationAnimateTile(),
                child: Row(
                  children: [
                    Text(
                      "Select Duration:",
                      style: t14_Light,
                    ),
                    Icon(
                      ((_basicController.durationAnimatedHeight.value == 0.0)
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up),
                      color: whiteColor,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
        Obx(() => AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 10),
          duration: Duration(milliseconds: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
                text: "Sent",
                textStyle: t14_Dark,
                height: 40,
                color: whiteColor,
                borderColor:
                (_basicController.typeIndex.value != 0) ? greyColor : greenColor,
                borderWidth: 5,
                borderRadius: 30,
                callback: () {
                  _basicController.changeType(0);
                  userTxnController.cType = "Sent";
                  userTxnController.getSortedList();
                },
              ),
              Button(
                text: "Received",
                textStyle: t14_Dark,
                height: 40,
                color: whiteColor,
                borderColor:
                (_basicController.typeIndex.value != 1) ? greyColor : greenColor,
                borderWidth: 5,
                borderRadius: 30,
                callback: () {
                  _basicController.changeType(1);
                  userTxnController.cType = "Received";
                  userTxnController.getSortedList();
                },
              ),
              Button(
                text: "All",
                textStyle: t14_Dark,
                height: 40,
                color: whiteColor,
                borderColor:
                (_basicController.typeIndex.value != 2) ? greyColor : greenColor,
                borderWidth: 5,
                borderRadius: 30,
                callback: () {
                  _basicController.changeType(2);
                  userTxnController.cType = "All";
                  userTxnController.getSortedList();
                },
              ),
            ],
          ),
          height: _basicController.typeAnimatedHeight.value,
          color: Colors.grey[200],
        )),

        Obx(() => AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: 10),
          duration: Duration(milliseconds: 120),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: "24h",
                    textStyle: t14_Dark,
                    width: 50,
                    height: 40,
                    color: whiteColor,
                    borderColor:
                    (_basicController.durationIndex.value != 0)
                        ? greyColor
                        : greenColor,
                    borderWidth: 5,
                    borderRadius: 15,
                    callback: () {
                      _basicController.changeDuration(0);
                      userTxnController.date =
                          now.subtract(Duration(hours: 24)).toString();
                      userTxnController.getSortedList();
                    },
                  ),
                  Button(
                    text: "3d",
                    textStyle: t14_Dark,
                    width: 50,
                    height: 40,
                    color: whiteColor,
                    borderColor:
                    (_basicController.durationIndex.value != 1)
                        ? greyColor
                        : greenColor,
                    borderWidth: 5,
                    borderRadius: 15,
                    callback: () {
                      _basicController.changeDuration(1);
                      userTxnController.date =
                          now.subtract(Duration(days: 3)).toString();
                      userTxnController.getSortedList();
                    },
                  ),
                  Button(
                    text: "7d",
                    textStyle: t14_Dark,
                    width: 50,
                    height: 40,
                    color: whiteColor,
                    borderColor:
                    (_basicController.durationIndex.value != 2)
                        ? greyColor
                        : greenColor,
                    borderWidth: 5,
                    borderRadius: 15,
                    callback: () {
                      _basicController.changeDuration(2);
                      userTxnController.date =
                          now.subtract(Duration(days: 7)).toString();
                      userTxnController.getSortedList();
                    },
                  ),
                  Button(
                    text: "30d",
                    textStyle: t14_Dark,
                    width: 50,
                    height: 40,
                    color: whiteColor,
                    borderColor:
                    (_basicController.durationIndex.value != 3)
                        ? greyColor
                        : greenColor,
                    borderWidth: 5,
                    borderRadius: 15,
                    callback: () {
                      _basicController.changeDuration(3);
                      userTxnController.date =
                          now.subtract(Duration(days: 30)).toString();
                      userTxnController.getSortedList();
                    },
                  ),
                  Button(
                    text: "All",
                    textStyle: t14_Dark,
                    width: 50,
                    height: 40,
                    color: whiteColor,
                    borderColor:
                    (_basicController.durationIndex.value != 4)
                        ? greyColor
                        : greenColor,
                    borderWidth: 5,
                    borderRadius: 15,
                    callback: () {
                      _basicController.changeDuration(4);
                      userTxnController.date = "2000-01-01";
                      userTxnController.getSortedList();
                    },
                  ),
                ],
              ),
          height: _basicController.durationAnimatedHeight.value,
          color: Colors.grey[200],
        )
        )
      ],
    );
  }
}

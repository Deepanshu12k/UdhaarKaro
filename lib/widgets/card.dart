import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/userdetails_controller.dart';
import 'package:udhaarkaroapp/customClass/navigations.dart';
import 'circularAvatar.dart';

//UserListCard
//HomeCard
//UserDetails
//NotificationCard

class UserListCard extends StatelessWidget {
  final str;
  final int itemIndex;

  UserListCard({
    @required this.str,
    @required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Avatar(
              radius: 25,
              networkImg: str.userList[itemIndex].pic,
            ),
            title: Text(
              str.userList[itemIndex].name,
              style: t18_Dark,
            ),
          ),
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 15),
        ),
        divider,
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final str;
  final int type;
  final int itemIndex;
  final UserDetailsController userTxnController = Get.find(tag: "userdetail-txn");

  HomeCard({@required this.str, @required this.type, @required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        userTxnController.yourId.value = str.txn[itemIndex].id;
        Navigate().toUserDetails(
            context, {"pic": str.txn[itemIndex].pic, "name": str.txn[itemIndex].name, "amount" : str.txn[itemIndex].amount.replaceAll("-",""), "type": type});
      },
      child: Card(
        margin: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 10,
            bottom: (itemIndex == (str.txn.length - 1) ? 80 : 10)),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
           child: Container(
             padding: EdgeInsets.symmetric(vertical: 15),
             child: ListTile(
               leading: Avatar(
                 radius: 22,
                 networkImg: str.txn[itemIndex].pic,
               ),
               title: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     str.txn[itemIndex].name,
                     style: t18_Dark,
                   ),
                   height10,
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         "Last Transaction On",
                         style: TextStyle(fontSize: 11, color: blackColor),
                       ),
                       Text(
                         DateFormat('d MMM y, H:m').format(DateTime.parse(str.txn[itemIndex].date)),
                         style: TextStyle(fontSize: 13, color: greyColor),
                       ),
                     ],
                   ),
                 ],
               ),
               //subtitle:
               trailing: Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   width2,
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("Rs.", style: t16_Dark),
                       Text(str.txn[itemIndex].amount.replaceAll("-",""), style: t28_Dark,)
                     ],
                     mainAxisSize: MainAxisSize.min,
                   ),

                 ],
               ),
             ),
           ),
      ),
    );
  }
}

class UserDetailCard extends StatelessWidget {
  final str;
  final int itemIndex;
  UserDetailCard({@required this.str, @required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          elevation: 0,
          margin: EdgeInsets.only(top: 5, bottom: (itemIndex == (str.sortedUserTxn.length - 1) ? 70 : 5)),
          child: ListTile(
            leading: Avatar(
              radius: 25,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (str.sortedUserTxn[itemIndex].id == str.sortedUserTxn[itemIndex].fromId) ? "Taken" : "Given",
                  style: h4_Dark,
                ),
                height5,
              ],
            ),
            subtitle: Text(
              DateFormat('d MMM y, H:m').format( DateTime.parse(str.sortedUserTxn[itemIndex].date)),
              style: TextStyle(color: greyColor, fontSize: 12),
            ),
            trailing: (str.sortedUserTxn[itemIndex].id != str.sortedUserTxn[itemIndex].fromId)
                ? Text(
              "- Rs." + str.sortedUserTxn[itemIndex].amount.toString(),
              style: minusPriceTextStyle,
            )
                : Text(
              "+ Rs." + str.sortedUserTxn[itemIndex].amount.toString(),
              style: plusPriceTextStyle,
            ),
          ),
        ));
  }
}

class NotificationCard extends StatelessWidget {
  final str;
  final int itemIndex;

  NotificationCard({@required this.str, @required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 0,

      child: ListTile(
        leading: Avatar(
          radius: 25,
          networkImg: str.txn[itemIndex].pic,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (str.txn[itemIndex].id == str.txn[itemIndex].fromId) ? "From" : "To",
              style: t12_Dark,
            ),
            Text(
              str.txn[itemIndex].name,
              style: t18_Dark,
            ),
            height5,
          ],
        ),
        subtitle: Text(
          DateFormat('d MMM y, H:m').format( DateTime.parse(str.txn[itemIndex].date)),
          style: TextStyle(color: greyColor, fontSize: 12),
        ),
        trailing: (str.txn[itemIndex].id != str.txn[itemIndex].fromId)
            ? Text(
                "- Rs." + str.txn[itemIndex].amount.toString(),
                style: minusPriceTextStyle,
              )
            : Text(
                "+ Rs." + str.txn[itemIndex].amount.toString(),
                style: plusPriceTextStyle,
              ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/widgets/bottomSheet.dart';
import 'package:udhaarkaroapp/widgets/card.dart';
import 'package:udhaarkaroapp/widgets/emptyscreen.dart';
import 'package:udhaarkaroapp/widgets/headers.dart';
import 'package:udhaarkaroapp/widgets/loaders.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  UserController _userController = Get.find(tag: "user-controller");
  UserListController _userListController = Get.find(tag: "user_list");

  @override
  void initState() {
    super.initState();
    if (_userListController.load.value == 1) {
      _userListController.getUserData(_userController.userModel.value.id);
    }
  }

  void setBottomSheet(limit, id) {
    showModalBottomSheet(
        context: context,
        //isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            color: lightGreyColor,
            child: UsersBottomSheet(
              amount: limit,
              fromId: _userController.userModel.value.id,
              toId: id,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Header(text: "User List"),
                  Flexible(child: Obx(() {
                    if (_userListController.load.value == 0) {
                      if (_userListController.userList.length > 0) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _userListController.userList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => setBottomSheet(
                                    _userListController.userList[index].limit,
                                    _userListController.userList[index].id),
                                child: UserListCard(
                                  str: _userListController,
                                  itemIndex: index,
                                ),
                              );
                            });
                      } else {
                        return EmptyScreen(
                          text: "OOPS! No Users found.",
                        );
                      }
                    } else {
                      return Center(
                          child: FoldingCubeLoader(
                        load: 1,
                        bgContainer: false,
                        color: darkBlueColor,
                      ));
                    }
                  }))
                ],
              ),
            ),

            Obx(() =>
                Center(child: CircularLoader(load: _userListController.updateLoad.value))
            )

          ],
        ),
      ),
    );
  }
}

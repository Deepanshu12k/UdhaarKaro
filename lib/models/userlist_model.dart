import 'dart:convert';

List<UserListModel> userListFromJson(String str) => List<UserListModel>.from(json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListToJson(List<UserListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
  UserListModel({
    this.id,
    this.pic,
    this.name,
    this.mobileNumber,
    this.limit
  });

  String id = "";
  String pic = "";
  String name = "";
  String mobileNumber = "";
  String limit = "";

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    id: json["id"],
    pic: json["pic"],
    name: json["name"],
    mobileNumber: json["mobile_number"],
    limit: json["limit_value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pic": pic,
    "name": name,
    "mobile_number": mobileNumber,
    "limit_value": limit
  };
}

import 'dart:convert';

List<UserModel> welcomeFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String welcomeToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id = "",
    this.pic = "",
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.password = "",
    this.accountType = "",
    this.businessMainCategory = "",
    this.businessSubCategory = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.lastLoginAt = "",
    this.status = "",
  });

  String id;
  dynamic pic;
  String name;
  String email;
  String mobileNumber;
  String password;
  String accountType;
  String businessMainCategory;
  String businessSubCategory;
  String createdAt;
  String updatedAt;
  String lastLoginAt;
  String status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    pic: json["pic"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    password: json["password"],
    accountType: json["account_type"],
    businessMainCategory: json["business_main_category"],
    businessSubCategory: json["business_sub_category"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    lastLoginAt: json["last_login_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pic": pic,
    "name": name,
    "email": email,
    "mobile_number": mobileNumber,
    "password" : password,
    "account_type": accountType,
    "business_main_category": businessMainCategory,
    "business_sub_category": businessSubCategory,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "last_login_at": lastLoginAt,
    "status": status,
  };
}

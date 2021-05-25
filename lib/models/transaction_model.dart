import 'dart:convert';

List<TransactionModel> transactionFromJson(String str) =>
    List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)));

String welcomeToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  String id;
  String pic;
  String name;
  String number;
  String fromId;
  String toId;
  String transactionId;
  String limit;
  String date;
  String type;
  String status;
  String amount;
  String note;

  TransactionModel({this.id = "",
    this.pic = "",
    this.name = "",
    this.number = "",
    this.fromId = "",
    this.toId = "",
    this.transactionId = "",
    this.limit = "",
    this.date = "",
    this.type = "",
    this.status = "",
    this.amount = "",
    this.note = ""});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          id: json["id"],
          pic: json["pic"],
          name: json["name"],
          number: json["mobile_number"],
          fromId: json["from_user_id"],
          toId: json["to_user_id"],
          transactionId: json["transaction_id"],
          limit: json["limit_value"],
          date: json["time_of_txn"],
          status: json["status"],
          amount: json["amount"],
          note: json["note"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "pic": pic,
        "name": name,
        "mobile_number": number,
        "from_user_id": fromId,
        "to_user_id": toId,
        "transaction_id": transactionId,
        "limit_value": limit,
        "time_of_txn": date,
        "status": status,
        "amount": amount,
        "note": note
      };
}

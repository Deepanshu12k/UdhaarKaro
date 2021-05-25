import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/transaction_model.dart';

class TransactionApiCall{

  Future<dynamic> addTxn(TransactionModel txnModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/addTransaction.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: txnModel.toJson());
      if(response.statusCode == 200) {
        return response.body;
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> checkUserWithLimit(id, number) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/checkUserWithLimit.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: {"id": id, "mobile_number": number});
      if(response.statusCode == 200) {
        return response.body;
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> checkUserNumber(id, number) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/checkUser.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: {"id": id, "mobile_number": number});
      if(response.statusCode == 200) {
        return response.body;
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> getAllTxn(String id) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/getAllTransactions.php', {'q': '{https}'});

    try {
      final response = await http.post(url, body: {"id" : id});
      if (response.statusCode == 200) {
        if(response.body.length > 0) {
          return transactionFromJson(response.body);
        }
        else{
          return response.body;
        }
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: "+ e.toString());
      return "error";
    }
  }

  Future<dynamic> getTakenTxn(String id) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/getTakenAmount.php', {'q': '{https}'});

    try {
      final response = await http.post(url, body: {"id" : id});
      if (response.statusCode == 200) {
        if(response.body.length > 0) {
          return transactionFromJson(response.body);
        }
        else{
          return response.body;
        }
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: "+ e.toString());
      return "error";
    }
  }

  Future<dynamic> getGivenTxn(String id) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/getGivenAmount.php', {'q': '{https}'});

    try {
      final response = await http.post(url, body: {"id" : id});
      if (response.statusCode == 200) {
        if(response.body.length > 0) {
          return transactionFromJson(response.body);
        }
        else{
          return response.body;
        }
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: "+ e.toString());
      return "error";
    }
  }

  Future<dynamic> getUserTransactions(String myid, String yourid) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/usersTransactions.php', {'q': '{https}'});

    try {
      final response = await http.post(url, body: {"myid" : myid, "yourid": yourid});
      if (response.statusCode == 200) {
        if(response.body.length > 0) {
          return transactionFromJson(response.body);
        }
        else{
          return response.body;
        }
      }
      else{
        print(response.body);
        return "error";
      }
    } catch (e) {
      print("error :: "+ e.toString());
      return "error";
    }
  }
}
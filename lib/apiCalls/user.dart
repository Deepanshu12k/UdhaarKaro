import 'package:http/http.dart' as http;
import 'package:udhaarkaroapp/models/user_model.dart';
import 'package:udhaarkaroapp/models/userlist_model.dart';

class UserApiCalls {

  Future<dynamic> addUser(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/signUp.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> logIn(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/login.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> update(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/update.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> updateImage(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/updateImage.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> updatePass(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/updatePass.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> checkUserData(UserModel userModel) async {
    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/checkUser.php', {'q': '{https}'});
    try {
      final response = await http.post(url, body: userModel.toJson());
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.body);
        return "error";
      }
    } catch (e) {
      print('error' + e.toString());
      return "error";
    }
  }

  Future<dynamic> getUsersList(String id) async {
    var url = Uri.https('www.pinsoutinnovation.com', '/udhaarkaro/getUsers.php',
        {'q': '{https}'});
    try {
      final response = await http.post(url, body: {"id" : id});
      if (response.statusCode == 200) {
        if(response.body.length > 0) {
          return userListFromJson(response.body);
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

  Future<dynamic> setUsersLimit(String fromId, String toId, String amount, String action) async {
    var url = Uri.https('www.pinsoutinnovation.com', '/udhaarkaro/setUserLimit.php',
        {'q': '{https}'});
    try {
      final response = await http.post(url, body: {"fromId" : fromId, "toId" : toId, "amount" : amount, "action" : action});
      if (response.statusCode == 200) {
        return response.body;
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

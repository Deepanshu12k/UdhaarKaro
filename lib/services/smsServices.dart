import 'package:http/http.dart' as http;


class SMS {
  Future sendSms(String number, String code) async {

    var url = Uri.https('www.pinsoutinnovation.com',
        '/udhaarkaro/sms.php', {'q': '{https}'});

    try {
      final response = await http.post(url, body: {"code" : code, "number": number});
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

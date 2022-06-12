import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class Net {
  String scanned;
  static var apiurl = "http://18.222.254.209/users/";
  var name, email, rgno, pno;
  Net(this.scanned) {
    log(scanned.toString());
  }
  Future<dynamic> getRequest(String token) async {
    http.Response response = await http.get(Uri.parse(apiurl + "qr/$scanned"));
    try {
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);
        log(decodedData);
        return decodedData;
      } else {
        return "Failed.";
      }
    } catch (exp) {
      return "Failed.";
    }
  }
}

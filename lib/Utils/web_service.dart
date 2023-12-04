import 'dart:convert';
import 'package:bath_service_project/models/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WebServices {
  static const _baseURL = "https://cqpplefitting.com/ad_cqpple/Api/";
  static const _deleteAccountFlag = "${_baseURL}Flag";
  static const _deleteAccount = "${_baseURL}UserDelete";

  static Future<BaseModel> getDeleteAccountFlag() async {
    var response = await http.get(Uri.parse(_deleteAccountFlag));
    final json = jsonDecode(response.body);
    return BaseModel.fromJson(json);
  }

  static Future<BaseModel> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final apikey = prefs.getString("apikey") ?? "";
    Map map = {"apikey": apikey};
    var response = await http.post(Uri.parse(_deleteAccount), body: map);
    final json = jsonDecode(response.body);
    print(json);
    return BaseModel.fromJson(json);
  }
}

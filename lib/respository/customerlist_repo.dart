import 'dart:convert';
import 'package:mns_management/constant/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future getCustomerList() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var myKey = preferences.getString("token") ?? "";
  var headers = {'mykey': myKey};
  try {
    final response =
        await http.get(Uri.parse(Config.customerList), headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> dataList = jsonResponse["data"];

      return dataList;
    }
  } catch (e) {
    throw Exception("unable");
  }
}

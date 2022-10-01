import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/modals/leaddata_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<LeadListModel>> getLeadList(String slug) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var loginData = preferences.getString("token") ?? "";
  Map<String, dynamic> decodeSvData = json.decode(loginData);

  String accessKey = '${decodeSvData["id"]}';
  var headers = {
    'accesskey2': accessKey,
    'mykey': loginData,
  };
  String url = Config.leadList + slug;

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    var leadData = jsonData["data"];

    List<LeadListModel> _fetchleadList = leadListModelFromJson(leadData);

    return _fetchleadList;
  } else {
    throw Exception(response.body.toString());
  }
}

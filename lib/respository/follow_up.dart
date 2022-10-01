import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/modals/followup_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<FollowupModel>> getFollowList(String slug) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var loginData = preferences.getString("token") ?? "";
  Map<String, dynamic> decodeSvData = json.decode(loginData);

  String accessKey = '${decodeSvData["id"]}';
  var headers = {
    'accesskey2': accessKey,
    'mykey': loginData,
  };

  // var slug = customerId + " " + branchId + orderStatus + startDate + endDate;

  String url = Config.followLead + slug;

  final response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);

    var followUpList = jsonData["data"];
    List<FollowupModel> _fetchFollow = followupModelFromJson(followUpList);

    return _fetchFollow;
  } else {
    throw Exception("Failed to load from API");
  }
}

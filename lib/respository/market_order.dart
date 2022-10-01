import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/modals/marketing_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<MarketingOrderModel>> getMarketingOrder(String slug) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var loginData = preferences.getString("token") ?? "";
  Map<String, dynamic> decodeSvData = json.decode(loginData);

  String accessKey = '${decodeSvData["id"]}';
  var headers = {
    'accesskey2': accessKey,
    'mykey': loginData,
  };

  String url = Config.baseurl +
      "/marketing_orders/$slug?relation=[%22Getcustomer%22,%22GetBranch%22,%22GetreportName%22,%22Getrequest%22,%22Getpartyname%22,%22Getcountry%22,%22Getinvoice%22]";

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var orderList = jsonData["data"];

    List<MarketingOrderModel> _fetchOrderList =
        marketingOrderModelFromJson(orderList);

    return _fetchOrderList;
  } else {
    throw Exception(jsonDecode(response.body.toString()));
  }
}

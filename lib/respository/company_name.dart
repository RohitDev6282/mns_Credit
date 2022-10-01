import 'dart:convert';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/modals/companylist.dart';
import 'package:http/http.dart' as http;

Future<List<CompanyListModel>> getCompanyList(String query) async {
  String apiUrl = Config.companySearch + query + "/company_name";

  final url = Uri.parse(apiUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var dataList = jsonResponse["data"] as List;
    print(dataList);
    return dataList
        .map((json) => CompanyListModel.fromJson(json))
        .where((company) {
      final nameLower = company.companyName.toString().toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  } else {
    throw Exception("Unable to load Api");
  }
}

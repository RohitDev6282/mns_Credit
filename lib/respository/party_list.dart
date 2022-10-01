import 'dart:convert';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/modals/partyname_model.dart';
import 'package:http/http.dart' as http;

// class PartyListAPi {
Future<List<PartyListModel>> getPartyList(String query) async {
  String apiUrl = Config.partyList + query + "/billing_party_name";

  final url = Uri.parse(apiUrl);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var dataList = jsonResponse["data"] as List;
    return dataList.map((json) => PartyListModel.fromJson(json)).where((party) {
      final partyName = party.billingPartyName.toString().toLowerCase();
      final gstno = party.gst.toString().toLowerCase();
      final queryLower = partyName.toLowerCase();

      return partyName.contains(queryLower) || gstno.contains(queryLower);
    }).toList();
  } else {
    throw Exception("Unable to load Api");
  }
}

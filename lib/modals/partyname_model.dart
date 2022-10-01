// To parse this JSON data, do
//
//     final partyListModel = partyListModelFromJson(jsonString);

import 'dart:convert';

List<PartyListModel> partyListModelFromJson(String str) =>
    List<PartyListModel>.from(
        json.decode(str).map((x) => PartyListModel.fromJson(x)));

String partyListModelToJson(List<PartyListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PartyListModel {
  PartyListModel({
    this.id,
    this.billingPartyName,
    this.gst,
  });

  int? id;
  String? billingPartyName;
  String? gst;

  factory PartyListModel.fromJson(Map<String, dynamic> json) => PartyListModel(
        id: json["id"] == null ? null : json["id"],
        billingPartyName: json["billing_party_name"] == null
            ? null
            : json["billing_party_name"],
        gst: json["gst"] == null ? null : json["gst"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "billing_party_name":
            billingPartyName == null ? null : billingPartyName,
        "gst": gst == null ? null : gst,
      };
}

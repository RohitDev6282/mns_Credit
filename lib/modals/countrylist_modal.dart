// To parse this JSON data, do
//
//     final countryListModel = countryListModelFromJson(jsonString);

import 'dart:convert';

List<CountryListModel> countryListModelFromJson(String str) =>
    List<CountryListModel>.from(
        json.decode(str).map((x) => CountryListModel.fromJson(x)));

String countryListModelToJson(List<CountryListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryListModel {
  CountryListModel({
    this.id,
    this.countryName,
  });

  int? id;
  String? countryName;

  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      CountryListModel(
        id: json["id"] == null ? null : json["id"],
        countryName: json["country_name"] == null ? null : json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "country_name": countryName == null ? null : countryName,
      };
}

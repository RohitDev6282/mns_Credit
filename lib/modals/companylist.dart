// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

List<CompanyListModel> companyListModelFromJson(String str) =>
    List<CompanyListModel>.from(
        json.decode(str).map((x) => CompanyListModel.fromJson(x)));

String companyListModelToJson(List<CompanyListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyListModel {
  CompanyListModel({
    this.id,
    this.companyName,
  });

  int? id;
  String? companyName;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        id: json["id"] == null ? null : json["id"],
        companyName: json["company_name"] == null ? null : json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_name": companyName == null ? null : companyName,
      };
}

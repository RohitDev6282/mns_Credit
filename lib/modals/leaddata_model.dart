// To parse this JSON data, do
//
//     final leadListModel = leadListModelFromJson(jsonString);

import 'dart:convert';

List<LeadListModel> leadListModelFromJson(String str) =>
    List<LeadListModel>.from(
        json.decode(str).map((x) => LeadListModel.fromJson(x)));

String leadListModelToJson(List<LeadListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadListModel {
  LeadListModel({
    required this.id,
    required this.customerName,
    required this.customerId,
    required this.ifscCode,
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.gst,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedDate,
    required this.modifiedBy,
  });

  int id;
  String customerName;
  int customerId;
  dynamic ifscCode;
  String country;
  String state;
  String city;
  String zip;
  String mobile;
  String address1;
  String address2;
  String address3;
  dynamic gst;
  int status;
  int createdBy;
  DateTime createdDate;
  DateTime modifiedDate;
  int modifiedBy;

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
        id: json["id"] == null ? null : json["id"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        ifscCode: json["ifsc_code"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        zip: json["zip"] == null ? null : json["zip"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        address1: json["Address1"] == null ? null : json["Address1"],
        address2: json["Address2"] == null ? null : json["Address2"],
        address3: json["Address3"] == null ? null : json["Address3"],
        gst: json["gst"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_name": customerName == null ? null : customerName,
        "customer_id": customerId == null ? null : customerId,
        "ifsc_code": ifscCode,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "zip": zip == null ? null : zip,
        "mobile": mobile == null ? null : mobile,
        "Address1": address1 == null ? null : address1,
        "Address2": address2 == null ? null : address2,
        "Address3": address3 == null ? null : address3,
        "gst": gst,
        "status": status == null ? null : status,
        "created_by": createdBy == null ? null : createdBy,
        "created_date":
            createdDate == null ? null : createdDate.toIso8601String(),
        "modified_date":
            modifiedDate == null ? null : modifiedDate.toIso8601String(),
        "modified_by": modifiedBy == null ? null : modifiedBy,
      };
}

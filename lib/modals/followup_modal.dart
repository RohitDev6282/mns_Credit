// To parse this JSON data, do
//
//     final followupModel = followupModelFromJson(jsonString);

import 'dart:convert';

List<FollowupModel> followupModelFromJson(String str) =>
    List<FollowupModel>.from(
        json.decode(str).map((x) => FollowupModel.fromJson(x)));

String followupModelToJson(List<FollowupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FollowupModel {
  FollowupModel({
    this.id,
    this.customerId,
    this.branchId,
    this.followupby,
    this.spoc,
    this.nameOfCordinator,
    this.type,
    this.followupDate,
    this.nextFollowupDate,
    this.email,
    this.phone,
    this.path,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerName,
  });

  int? id;
  int? customerId;
  int? branchId;
  String? followupby;
  String? spoc;
  String? nameOfCordinator;
  String? type;
  DateTime? followupDate;
  dynamic nextFollowupDate;
  String? email;
  String? phone;
  String? path;
  String? description;
  int? createdBy;
  int? updatedBy;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CustomerName? customerName;

  factory FollowupModel.fromJson(Map<String, dynamic> json) => FollowupModel(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        followupby: json["followupby"] == null ? null : json["followupby"],
        spoc: json["spoc"] == null ? null : json["spoc"],
        nameOfCordinator: json["name_of_cordinator"] == null
            ? null
            : json["name_of_cordinator"],
        type: json["type"] == null ? null : json["type"],
        followupDate: json["followup_date"] == null
            ? null
            : DateTime.parse(json["followup_date"]),
        nextFollowupDate: json["next_followup_date"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        path: json["path"] == null ? null : json["path"],
        description: json["description"] == null ? null : json["description"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customerName: json["customer_name"] == null
            ? null
            : CustomerName.fromJson(json["customer_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_id": customerId == null ? null : customerId,
        "branch_id": branchId == null ? null : branchId,
        "followupby": followupby == null ? null : followupby,
        "spoc": spoc == null ? null : spoc,
        "name_of_cordinator":
            nameOfCordinator == null ? null : nameOfCordinator,
        "type": type == null ? null : type,
        "followup_date":
            followupDate == null ? null : followupDate?.toIso8601String(),
        "next_followup_date": nextFollowupDate,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "path": path == null ? null : path,
        "description": description == null ? null : description,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "customer_name": customerName == null ? null : customerName!.toJson(),
      };
}

class CustomerName {
  CustomerName({
    this.id,
    this.customerName,
    this.address1,
    this.address2,
    this.address3,
    this.underValue,
    this.currency,
    this.capingValue,
    this.assignedQc,
    this.updatedTime,
    this.createdTime,
    this.country,
    this.zip,
    this.state,
    this.city,
    this.type,
    this.clientCode,
    this.ipAddress,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
    this.typeCode,
    this.freeDuration,
  });

  int? id;
  String? customerName;
  String? address1;
  String? address2;
  String? address3;
  dynamic underValue;
  String? currency;
  int? capingValue;
  int? assignedQc;
  String? updatedTime;
  String? createdTime;
  String? country;
  String? zip;
  String? state;
  String? city;
  String? type;
  String? clientCode;
  String? ipAddress;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  int? status;
  String? typeCode;
  int? freeDuration;

  factory CustomerName.fromJson(Map<String, dynamic> json) => CustomerName(
        id: json["id"] == null ? null : json["id"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        address3: json["address3"] == null ? null : json["address3"],
        underValue: json["under_value"],
        currency: json["currency"] == null ? null : json["currency"],
        capingValue: json["caping_value"] == null ? null : json["caping_value"],
        assignedQc: json["assigned_qc"] == null ? null : json["assigned_qc"],
        updatedTime: json["updated_time"] == null ? null : json["updated_time"],
        createdTime: json["created_time"] == null ? null : json["created_time"],
        country: json["country"] == null ? null : json["country"],
        zip: json["zip"] == null ? null : json["zip"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        type: json["type"] == null ? null : json["type"],
        clientCode: json["client_code"] == null ? null : json["client_code"],
        ipAddress: json["ip_address"] == null ? null : json["ip_address"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        modifiedDate:
            json["modified_date"] == null ? null : json["modified_date"],
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        status: json["status"] == null ? null : json["status"],
        typeCode: json["type_code"] == null ? null : json["type_code"],
        freeDuration:
            json["free_duration"] == null ? null : json["free_duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_name": customerName == null ? null : customerName,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "address3": address3 == null ? null : address3,
        "under_value": underValue,
        "currency": currency == null ? null : currency,
        "caping_value": capingValue == null ? null : capingValue,
        "assigned_qc": assignedQc == null ? null : assignedQc,
        "updated_time": updatedTime == null ? null : updatedTime,
        "created_time": createdTime == null ? null : createdTime,
        "country": country == null ? null : country,
        "zip": zip == null ? null : zip,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "type": type == null ? null : type,
        "client_code": clientCode == null ? null : clientCode,
        "ip_address": ipAddress == null ? null : ipAddress,
        "created_date": createdDate == null ? null : createdDate,
        "created_by": createdBy == null ? null : createdBy,
        "modified_date": modifiedDate == null ? null : modifiedDate,
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "status": status == null ? null : status,
        "type_code": typeCode == null ? null : typeCode,
        "free_duration": freeDuration == null ? null : freeDuration,
      };
}

// To parse this JSON data, do
//
//     final spokePersonDetail = spokePersonDetailFromJson(jsonString)?;

import 'dart:convert';

List<SpokePersonDetail> spokePersonDetailFromJson(String str) =>
    List<SpokePersonDetail>.from(
        json.decode(str).map((x) => SpokePersonDetail.fromJson(x)));

String? spokePersonDetailToJson(List<SpokePersonDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpokePersonDetail {
  SpokePersonDetail({
    this.id,
    this.branchId,
    this.loginid,
    this.password,
    this.spocName,
    this.spocEmail,
    this.spocPhone,
    this.spocMobile,
    this.designation,
    this.displayName,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
    this.loginVia,
    this.otp,
    this.otpOn,
    this.accessToken,
    this.overseasAccess,
    this.databaseReportAccess,
    this.preliminaryReportAccess,
    this.requestDetailReportAccess,
    this.instaDetailReportAccess,
    this.passwordChangedDate,
    this.spocDeafult,
  });

  int? id;
  int? branchId;
  dynamic loginid;
  dynamic password;
  String? spocName;
  String? spocEmail;
  dynamic spocPhone;
  dynamic spocMobile;
  dynamic designation;
  String? displayName;
  DateTime? createdDate;
  String? createdBy;
  DateTime? modifiedDate;
  String? modifiedBy;
  int? status;
  dynamic loginVia;
  String? otp;
  dynamic otpOn;
  dynamic accessToken;
  String? overseasAccess;
  String? databaseReportAccess;
  String? preliminaryReportAccess;
  String? requestDetailReportAccess;
  dynamic instaDetailReportAccess;
  dynamic passwordChangedDate;
  String? spocDeafult;

  factory SpokePersonDetail.fromJson(Map<String, dynamic> json) =>
      SpokePersonDetail(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        loginid: json["loginid"],
        password: json["password"],
        spocName: json["spoc_name"] == null ? null : json["spoc_name"],
        spocEmail: json["spoc_email"] == null ? null : json["spoc_email"],
        spocPhone: json["spoc_phone"],
        spocMobile: json["spoc_mobile"],
        designation: json["designation"],
        displayName: json["display_name"] == null ? null : json["display_name"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        status: json["status"] == null ? null : json["status"],
        loginVia: json["login_via"],
        otp: json["otp"] == null ? null : json["otp"],
        otpOn: json["otp_on"],
        accessToken: json["access_token"],
        overseasAccess:
            json["overseas_access"] == null ? null : json["overseas_access"],
        databaseReportAccess: json["database_report_access"] == null
            ? null
            : json["database_report_access"],
        preliminaryReportAccess: json["preliminary_report_access"] == null
            ? null
            : json["preliminary_report_access"],
        requestDetailReportAccess: json["request_detail_report_access"] == null
            ? null
            : json["request_detail_report_access"],
        instaDetailReportAccess: json["insta_detail_report_access"],
        passwordChangedDate: json["password_changed_date"],
        spocDeafult: json["spoc_deafult"] == null ? null : json["spoc_deafult"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branch_id": branchId == null ? null : branchId,
        "loginid": loginid,
        "password": password,
        "spoc_name": spocName == null ? null : spocName,
        "spoc_email": spocEmail == null ? null : spocEmail,
        "spoc_phone": spocPhone,
        "spoc_mobile": spocMobile,
        "designation": designation,
        "display_name": displayName == null ? null : displayName,
        "created_date":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "created_by": createdBy == null ? null : createdBy,
        "modified_date":
            modifiedDate == null ? null : modifiedDate!.toIso8601String(),
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "status": status == null ? null : status,
        "login_via": loginVia,
        "otp": otp == null ? null : otp,
        "otp_on": otpOn,
        "access_token": accessToken,
        "overseas_access": overseasAccess == null ? null : overseasAccess,
        "database_report_access":
            databaseReportAccess == null ? null : databaseReportAccess,
        "preliminary_report_access":
            preliminaryReportAccess == null ? null : preliminaryReportAccess,
        "request_detail_report_access": requestDetailReportAccess == null
            ? null
            : requestDetailReportAccess,
        "insta_detail_report_access": instaDetailReportAccess,
        "password_changed_date": passwordChangedDate,
        "spoc_deafult": spocDeafult == null ? null : spocDeafult,
      };
}

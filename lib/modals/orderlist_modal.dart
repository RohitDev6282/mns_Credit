// To parse this JSON data, do
//
//     final searchApiModel = searchApiModelFromJson(jsonString);

import 'dart:convert';

List<SearchApiModel> searchApiModelFromJson(String str) =>
    List<SearchApiModel>.from(
        json.decode(str).map((x) => SearchApiModel.fromJson(x)));

String searchApiModelToJson(List<SearchApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchApiModel {
  SearchApiModel({
    this.id,
    this.companyName,
    this.regNo,
    this.mnsidentifier,
    this.customerId,
    this.branchId,
    this.loginId,
    this.proformaInvoiceId,
    this.receiptnumber,
    this.category,
    this.invoiceId,
    this.orderStatus,
    this.clientRefNumber,
    this.paymentMode,
    this.paymentGateway,
    this.taxableValue,
    this.tax,
    this.discountAllow,
    this.discountValue,
    this.discountType,
    this.discount,
    this.payableValue,
    this.billto,
    this.partyname,
    this.requestType,
    this.requestHitType,
    this.paymentStatus,
    this.description,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.deliveryType,
    this.deliveryDate,
    this.cancelDate,
    this.country,
    this.status,
    this.invoiceGen,
    this.invoiceGenDate,
    this.requestVia,
    this.requestMode,
    this.bulkpath,
    this.localRefrence,
    this.complimentery,
    this.getcustomer,
    this.getBranch,
    this.getreportName,
    this.getrequest,
    this.getpartyname,
    this.getcountry,
    this.getinvoice,
  });

  int? id;
  String? companyName;
  dynamic regNo;
  dynamic mnsidentifier;
  int? customerId;
  int? branchId;
  dynamic loginId;
  dynamic proformaInvoiceId;
  String? receiptnumber;
  String? category;
  String? invoiceId;
  String? orderStatus;
  String? clientRefNumber;
  dynamic paymentMode;
  dynamic paymentGateway;
  String? taxableValue;
  String? tax;
  String? discountAllow;
  String? discountValue;
  String? discountType;
  String? discount;
  String? payableValue;
  String? billto;
  dynamic partyname;
  int? requestType;
  dynamic requestHitType;
  String? paymentStatus;
  dynamic description;
  DateTime? createdDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  String? deliveryType;
  DateTime? deliveryDate;
  dynamic cancelDate;
  String? country;
  int? status;
  int? invoiceGen;
  DateTime? invoiceGenDate;
  String? requestVia;
  String? requestMode;
  String? bulkpath;
  String? localRefrence;
  String? complimentery;
  Getcustomer? getcustomer;
  GetBranch? getBranch;
  GetreportName? getreportName;
  Getrequest? getrequest;
  dynamic getpartyname;
  Getcountry? getcountry;
  Getinvoice? getinvoice;

  factory SearchApiModel.fromJson(Map<String, dynamic> json) => SearchApiModel(
        id: json["id"] == null ? null : json["id"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        regNo: json["reg_no"],
        mnsidentifier: json["mnsidentifier"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        loginId: json["login_id"],
        proformaInvoiceId: json["proforma_invoice_id"],
        receiptnumber:
            json["receiptnumber"] == null ? null : json["receiptnumber"],
        category: json["category"] == null ? null : json["category"],
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        clientRefNumber: json["client_ref_number"] == null
            ? null
            : json["client_ref_number"],
        paymentMode: json["payment_mode"],
        paymentGateway: json["payment_gateway"],
        taxableValue:
            json["taxable_value"] == null ? null : json["taxable_value"],
        tax: json["tax"] == null ? null : json["tax"],
        discountAllow:
            json["discount_allow"] == null ? null : json["discount_allow"],
        discountValue:
            json["discount_value"] == null ? null : json["discount_value"],
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        discount: json["discount"] == null ? null : json["discount"],
        payableValue:
            json["payable_value"] == null ? null : json["payable_value"],
        billto: json["billto"] == null ? null : json["billto"],
        partyname: json["partyname"],
        requestType: json["request_type"] == null ? null : json["request_type"],
        requestHitType: json["request_hit_type"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        description: json["description"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        cancelDate: json["cancel_date"],
        country: json["country"] == null ? null : json["country"],
        status: json["status"] == null ? null : json["status"],
        invoiceGen: json["invoice_gen"] == null ? null : json["invoice_gen"],
        invoiceGenDate: json["invoice_gen_date"] == null
            ? null
            : DateTime.parse(json["invoice_gen_date"]),
        requestVia: json["request_via"] == null ? null : json["request_via"],
        requestMode: json["request_mode"] == null ? null : json["request_mode"],
        bulkpath: json["bulkpath"] == null ? null : json["bulkpath"],
        localRefrence:
            json["local_refrence"] == null ? null : json["local_refrence"],
        complimentery:
            json["Complimentery"] == null ? null : json["Complimentery"],
        getcustomer: json["getcustomer"] == null
            ? null
            : Getcustomer.fromJson(json["getcustomer"]),
        getBranch: json["get_branch"] == null
            ? null
            : GetBranch.fromJson(json["get_branch"]),
        getreportName: json["getreport_name"] == null
            ? null
            : GetreportName.fromJson(json["getreport_name"]),
        getrequest: json["getrequest"] == null
            ? null
            : Getrequest.fromJson(json["getrequest"]),
        getpartyname: json["getpartyname"],
        getcountry: json["getcountry"] == null
            ? null
            : Getcountry.fromJson(json["getcountry"]),
        getinvoice: json["getinvoice"] == null
            ? null
            : Getinvoice.fromJson(json["getinvoice"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_name": companyName == null ? null : companyName,
        "reg_no": regNo,
        "mnsidentifier": mnsidentifier,
        "customer_id": customerId == null ? null : customerId,
        "branch_id": branchId == null ? null : branchId,
        "login_id": loginId,
        "proforma_invoice_id": proformaInvoiceId,
        "receiptnumber": receiptnumber == null ? null : receiptnumber,
        "category": category == null ? null : category,
        "invoice_id": invoiceId == null ? null : invoiceId,
        "order_status": orderStatus == null ? null : orderStatus,
        "client_ref_number": clientRefNumber == null ? null : clientRefNumber,
        "payment_mode": paymentMode,
        "payment_gateway": paymentGateway,
        "taxable_value": taxableValue == null ? null : taxableValue,
        "tax": tax == null ? null : tax,
        "discount_allow": discountAllow == null ? null : discountAllow,
        "discount_value": discountValue == null ? null : discountValue,
        "discount_type": discountType == null ? null : discountType,
        "discount": discount == null ? null : discount,
        "payable_value": payableValue == null ? null : payableValue,
        "billto": billto == null ? null : billto,
        "partyname": partyname,
        "request_type": requestType == null ? null : requestType,
        "request_hit_type": requestHitType,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "description": description,
        "created_date":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "created_by": createdBy == null ? null : createdBy,
        "updated_date":
            updatedDate == null ? null : updatedDate!.toIso8601String(),
        "updated_by": updatedBy == null ? null : updatedBy,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "delivery_date":
            deliveryDate == null ? null : deliveryDate!.toIso8601String(),
        "cancel_date": cancelDate,
        "country": country == null ? null : country,
        "status": status == null ? null : status,
        "invoice_gen": invoiceGen == null ? null : invoiceGen,
        "invoice_gen_date": invoiceGenDate == null
            ? null
            : "${invoiceGenDate!.year.toString().padLeft(4, '0')}-${invoiceGenDate!.month.toString().padLeft(2, '0')}-${invoiceGenDate!.day.toString().padLeft(2, '0')}",
        "request_via": requestVia == null ? null : requestVia,
        "request_mode": requestMode == null ? null : requestMode,
        "bulkpath": bulkpath == null ? null : bulkpath,
        "local_refrence": localRefrence == null ? null : localRefrence,
        "Complimentery": complimentery == null ? null : complimentery,
        "getcustomer": getcustomer == null ? null : getcustomer!.toJson(),
        "get_branch": getBranch == null ? null : getBranch!.toJson(),
        "getreport_name":
            getreportName == null ? null : getreportName!.toJson(),
        "getrequest": getrequest == null ? null : getrequest!.toJson(),
        "getpartyname": getpartyname,
        "getcountry": getcountry == null ? null : getcountry!.toJson(),
        "getinvoice": getinvoice == null ? null : getinvoice!.toJson(),
      };
}

class GetBranch {
  GetBranch({
    this.id,
    this.customerId,
    this.branchName,
    this.displayName,
    this.bankBranch,
    this.loginid,
    this.bankType,
    this.emailid,
    this.emailid2,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.region,
    this.customerCode,
    this.customerCodeBranchCode,
    this.ifsc,
    this.gstin,
    this.currency,
    this.salesAgentId,
    this.zone,
    this.valueCap,
    this.underValue,
    this.mailCap,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
  });

  int? id;
  int? customerId;
  String? branchName;
  dynamic displayName;
  String? bankBranch;
  dynamic loginid;
  dynamic bankType;
  String? emailid;
  dynamic emailid2;
  String? address1;
  String? address2;
  dynamic address3;
  String? city;
  String? state;
  String? country;
  String? pincode;
  int? region;
  String? customerCode;
  String? customerCodeBranchCode;
  String? ifsc;
  String? gstin;
  dynamic currency;
  int? salesAgentId;
  int? zone;
  dynamic valueCap;
  dynamic underValue;
  dynamic mailCap;
  DateTime? createdDate;
  String? createdBy;
  DateTime? modifiedDate;
  String? modifiedBy;
  int? status;

  factory GetBranch.fromJson(Map<String, dynamic> json) => GetBranch(
        id: json["id"] == null ? null : json["id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        displayName: json["display_name"],
        bankBranch: json["bank_branch"] == null ? null : json["bank_branch"],
        loginid: json["loginid"],
        bankType: json["bank_type"],
        emailid: json["emailid"] == null ? null : json["emailid"],
        emailid2: json["emailid2"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        address3: json["address3"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        region: json["region"] == null ? null : json["region"],
        customerCode:
            json["customer_code"] == null ? null : json["customer_code"],
        customerCodeBranchCode: json["customer_code_branch_code"] == null
            ? null
            : json["customer_code_branch_code"],
        ifsc: json["ifsc"] == null ? null : json["ifsc"],
        gstin: json["gstin"] == null ? null : json["gstin"],
        currency: json["currency"],
        salesAgentId:
            json["sales_agent_id"] == null ? null : json["sales_agent_id"],
        zone: json["zone"] == null ? null : json["zone"],
        valueCap: json["value_cap"],
        underValue: json["under_value"],
        mailCap: json["mail_cap"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "customer_id": customerId == null ? null : customerId,
        "branch_name": branchName == null ? null : branchName,
        "display_name": displayName,
        "bank_branch": bankBranch == null ? null : bankBranch,
        "loginid": loginid,
        "bank_type": bankType,
        "emailid": emailid == null ? null : emailid,
        "emailid2": emailid2,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "address3": address3,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "pincode": pincode == null ? null : pincode,
        "region": region == null ? null : region,
        "customer_code": customerCode == null ? null : customerCode,
        "customer_code_branch_code":
            customerCodeBranchCode == null ? null : customerCodeBranchCode,
        "ifsc": ifsc == null ? null : ifsc,
        "gstin": gstin == null ? null : gstin,
        "currency": currency,
        "sales_agent_id": salesAgentId == null ? null : salesAgentId,
        "zone": zone == null ? null : zone,
        "value_cap": valueCap,
        "under_value": underValue,
        "mail_cap": mailCap,
        "created_date": createdDate == null
            ? null
            : "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy == null ? null : createdBy,
        "modified_date": modifiedDate == null
            ? null
            : "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "status": status == null ? null : status,
      };
}

class Getcountry {
  Getcountry({
    this.id,
    this.countryName,
    this.regionId,
    this.currencyTitle,
    this.currency,
    this.shortCode,
    this.status,
    this.modifiedDate,
    this.modifiedBy,
    this.createdBy,
    this.createdDate,
  });

  int? id;
  String? countryName;
  String? regionId;
  String? currencyTitle;
  String? currency;
  String? shortCode;
  int? status;
  DateTime? modifiedDate;
  String? modifiedBy;
  String? createdBy;
  String? createdDate;

  factory Getcountry.fromJson(Map<String, dynamic> json) => Getcountry(
        id: json["id"] == null ? null : json["id"],
        countryName: json["country_name"] == null ? null : json["country_name"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        currencyTitle:
            json["currency_title"] == null ? null : json["currency_title"],
        currency: json["currency"] == null ? null : json["currency"],
        shortCode: json["short_code"] == null ? null : json["short_code"],
        status: json["status"] == null ? null : json["status"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "country_name": countryName == null ? null : countryName,
        "region_id": regionId == null ? null : regionId,
        "currency_title": currencyTitle == null ? null : currencyTitle,
        "currency": currency == null ? null : currency,
        "short_code": shortCode == null ? null : shortCode,
        "status": status == null ? null : status,
        "modified_date": modifiedDate == null
            ? null
            : "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "created_by": createdBy == null ? null : createdBy,
        "created_date": createdDate == null ? null : createdDate,
      };
}

class Getcustomer {
  Getcustomer({
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
  dynamic address2;
  dynamic address3;
  dynamic underValue;
  String? currency;
  int? capingValue;
  int? assignedQc;
  dynamic updatedTime;
  dynamic createdTime;
  String? country;
  String? zip;
  String? state;
  String? city;
  String? type;
  String? clientCode;
  String? ipAddress;
  String? createdDate;
  dynamic createdBy;
  String? modifiedDate;
  String? modifiedBy;
  int? status;
  String? typeCode;
  int? freeDuration;

  factory Getcustomer.fromJson(Map<String, dynamic> json) => Getcustomer(
        id: json["id"] == null ? null : json["id"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        underValue: json["under_value"],
        currency: json["currency"] == null ? null : json["currency"],
        capingValue: json["caping_value"] == null ? null : json["caping_value"],
        assignedQc: json["assigned_qc"] == null ? null : json["assigned_qc"],
        updatedTime: json["updated_time"],
        createdTime: json["created_time"],
        country: json["country"] == null ? null : json["country"],
        zip: json["zip"] == null ? null : json["zip"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        type: json["type"] == null ? null : json["type"],
        clientCode: json["client_code"] == null ? null : json["client_code"],
        ipAddress: json["ip_address"] == null ? null : json["ip_address"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        createdBy: json["created_by"],
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
        "address2": address2,
        "address3": address3,
        "under_value": underValue,
        "currency": currency == null ? null : currency,
        "caping_value": capingValue == null ? null : capingValue,
        "assigned_qc": assignedQc == null ? null : assignedQc,
        "updated_time": updatedTime,
        "created_time": createdTime,
        "country": country == null ? null : country,
        "zip": zip == null ? null : zip,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "type": type == null ? null : type,
        "client_code": clientCode == null ? null : clientCode,
        "ip_address": ipAddress == null ? null : ipAddress,
        "created_date": createdDate == null ? null : createdDate,
        "created_by": createdBy,
        "modified_date": modifiedDate == null ? null : modifiedDate,
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "status": status == null ? null : status,
        "type_code": typeCode == null ? null : typeCode,
        "free_duration": freeDuration == null ? null : freeDuration,
      };
}

class Getinvoice {
  Getinvoice({
    this.id,
    this.userId,
    this.customerId,
    this.branchId,
    this.loginId,
    this.invoiceNumber,
    this.invoiceDate,
    this.invoiceTitile,
    this.invoiceAmount,
    this.invoiceAmountTax,
    this.invoiceAmountTotal,
    this.actiualAmount,
    this.invoiceAmountOff,
    this.invoiceAmountReceive,
    this.invoicePaymentDate,
    this.batchNo,
    this.invoicePaymentStatus,
    this.status,
    this.invoiceBankId,
    this.billTo,
    this.modifiedDate,
    this.createdDate,
    this.taxExempted,
    this.currency,
    this.createdBy,
    this.modifiedBy,
    this.description,
    this.regNo,
    this.invoicePath,
    this.invoiceType,
    this.degitalSignature,
    this.preInvoiceNumber,
    this.reason,
    this.invoiceMadeBy,
  });

  int? id;
  int? userId;
  int? customerId;
  int? branchId;
  dynamic loginId;
  String? invoiceNumber;
  DateTime? invoiceDate;
  String? invoiceTitile;
  String? invoiceAmount;
  int? invoiceAmountTax;
  String? invoiceAmountTotal;
  String? actiualAmount;
  String? invoiceAmountOff;
  String? invoiceAmountReceive;
  dynamic invoicePaymentDate;
  String? batchNo;
  int? invoicePaymentStatus;
  int? status;
  int? invoiceBankId;
  String? billTo;
  DateTime? modifiedDate;
  DateTime? createdDate;
  int? taxExempted;
  String? currency;
  int? createdBy;
  int? modifiedBy;
  String? description;
  String? regNo;
  String? invoicePath;
  String? invoiceType;
  int? degitalSignature;
  String? preInvoiceNumber;
  String? reason;
  String? invoiceMadeBy;

  factory Getinvoice.fromJson(Map<String, dynamic> json) => Getinvoice(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        loginId: json["login_id"],
        invoiceNumber:
            json["invoice_number"] == null ? null : json["invoice_number"],
        invoiceDate: json["invoice_date"] == null
            ? null
            : DateTime.parse(json["invoice_date"]),
        invoiceTitile:
            json["invoice_titile"] == null ? null : json["invoice_titile"],
        invoiceAmount:
            json["invoice_amount"] == null ? null : json["invoice_amount"],
        invoiceAmountTax: json["invoice_amount_tax"] == null
            ? null
            : json["invoice_amount_tax"],
        invoiceAmountTotal: json["invoice_amount_total"] == null
            ? null
            : json["invoice_amount_total"],
        actiualAmount:
            json["actiual_amount"] == null ? null : json["actiual_amount"],
        invoiceAmountOff: json["invoice_amount_off"] == null
            ? null
            : json["invoice_amount_off"],
        invoiceAmountReceive: json["invoice_amount_receive"] == null
            ? null
            : json["invoice_amount_receive"],
        invoicePaymentDate: json["invoice_payment_date"],
        batchNo: json["batch_no"] == null ? null : json["batch_no"],
        invoicePaymentStatus: json["invoice_payment_status"] == null
            ? null
            : json["invoice_payment_status"],
        status: json["status"] == null ? null : json["status"],
        invoiceBankId:
            json["invoice_bank_id"] == null ? null : json["invoice_bank_id"],
        billTo: json["bill_to"] == null ? null : json["bill_to"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        taxExempted: json["tax_exempted"] == null ? null : json["tax_exempted"],
        currency: json["currency"] == null ? null : json["currency"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        description: json["description"] == null ? null : json["description"],
        regNo: json["reg_no"] == null ? null : json["reg_no"],
        invoicePath: json["invoice_path"] == null ? null : json["invoice_path"],
        invoiceType: json["invoice_type"] == null ? null : json["invoice_type"],
        degitalSignature: json["degital_signature"] == null
            ? null
            : json["degital_signature"],
        preInvoiceNumber: json["pre_invoice_number"] == null
            ? null
            : json["pre_invoice_number"],
        reason: json["reason"] == null ? null : json["reason"],
        invoiceMadeBy:
            json["invoice_made_by"] == null ? null : json["invoice_made_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "customer_id": customerId == null ? null : customerId,
        "branch_id": branchId == null ? null : branchId,
        "login_id": loginId,
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "invoice_date": invoiceDate == null
            ? null
            : "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
        "invoice_titile": invoiceTitile == null ? null : invoiceTitile,
        "invoice_amount": invoiceAmount == null ? null : invoiceAmount,
        "invoice_amount_tax":
            invoiceAmountTax == null ? null : invoiceAmountTax,
        "invoice_amount_total":
            invoiceAmountTotal == null ? null : invoiceAmountTotal,
        "actiual_amount": actiualAmount == null ? null : actiualAmount,
        "invoice_amount_off":
            invoiceAmountOff == null ? null : invoiceAmountOff,
        "invoice_amount_receive":
            invoiceAmountReceive == null ? null : invoiceAmountReceive,
        "invoice_payment_date": invoicePaymentDate,
        "batch_no": batchNo == null ? null : batchNo,
        "invoice_payment_status":
            invoicePaymentStatus == null ? null : invoicePaymentStatus,
        "status": status == null ? null : status,
        "invoice_bank_id": invoiceBankId == null ? null : invoiceBankId,
        "bill_to": billTo == null ? null : billTo,
        "modified_date":
            modifiedDate == null ? null : modifiedDate!.toIso8601String(),
        "created_date":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "tax_exempted": taxExempted == null ? null : taxExempted,
        "currency": currency == null ? null : currency,
        "created_by": createdBy == null ? null : createdBy,
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "description": description == null ? null : description,
        "reg_no": regNo == null ? null : regNo,
        "invoice_path": invoicePath == null ? null : invoicePath,
        "invoice_type": invoiceType == null ? null : invoiceType,
        "degital_signature": degitalSignature == null ? null : degitalSignature,
        "pre_invoice_number":
            preInvoiceNumber == null ? null : preInvoiceNumber,
        "reason": reason == null ? null : reason,
        "invoice_made_by": invoiceMadeBy == null ? null : invoiceMadeBy,
      };
}

class GetreportName {
  GetreportName({
    this.id,
    this.reportType,
    this.locality,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.status,
  });

  int? id;
  String? reportType;
  String? locality;
  DateTime? createdDate;
  String? createdBy;
  DateTime? modifiedDate;
  String? modifiedBy;
  int? status;

  factory GetreportName.fromJson(Map<String, dynamic> json) => GetreportName(
        id: json["id"] == null ? null : json["id"],
        reportType: json["report_type"] == null ? null : json["report_type"],
        locality: json["locality"] == null ? null : json["locality"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedBy: json["modified_by"] == null ? null : json["modified_by"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "report_type": reportType == null ? null : reportType,
        "locality": locality == null ? null : locality,
        "created_date": createdDate == null
            ? null
            : "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy == null ? null : createdBy,
        "modified_date": modifiedDate == null
            ? null
            : "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_by": modifiedBy == null ? null : modifiedBy,
        "status": status == null ? null : status,
      };
}

class Getrequest {
  Getrequest({
    this.id,
    this.requestId,
    this.requestBy,
    this.customerId,
    this.branchId,
    this.loginId,
    this.orderId,
    this.companyName,
    this.companyId,
    this.country,
    this.address1,
    this.city,
    this.pinCode,
    this.gst,
    this.pan,
    this.vat,
    this.cst,
    this.regNumber,
    this.phoneNumber,
    this.mobile,
    this.faxNumber,
    this.banker,
    this.contactPerson,
    this.comment,
    this.clientRef,
    this.currencyLimit,
    this.currency,
    this.sample,
    this.billto,
    this.partyname,
    this.partygstin,
    this.customerUniqueId,
    this.localRefNumber,
    this.localReportRefNumber,
    this.reportTypeRequired,
    this.reportTypeDelivered,
    this.reportFrequency,
    this.paymentCurrency,
    this.paymentMode,
    this.requestStatus,
    this.cancelBy,
    this.cancelDate,
    this.orderDate,
    this.reportDateOfDelivery,
    this.reportDeliveryDate,
    this.finalDeliveryDate,
    this.deliveryTime,
    this.hardcopy,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.address3,
    this.address2,
    this.requestMode,
    this.salesAgentCode,
    this.contactPersonNumber,
    this.clientReferenceName,
    this.clientContactPerson,
    this.bankDetails,
    this.tradeName,
    this.status,
    this.alternateNumber,
    this.tradeLicenceNumber,
    this.website,
    this.emailId,
    this.requestLocality,
    this.reportType,
    this.reportSpeed,
    this.subjectCode,
    this.qcAssign,
    this.legalFrom,
    this.dpCode,
  });

  int? id;
  dynamic requestId;
  dynamic requestBy;
  int? customerId;
  int? branchId;
  dynamic loginId;
  int? orderId;
  String? companyName;
  String? companyId;
  String? country;
  String? address1;
  dynamic city;
  dynamic pinCode;
  dynamic gst;
  String? pan;
  dynamic vat;
  dynamic cst;
  dynamic regNumber;
  String? phoneNumber;
  dynamic mobile;
  dynamic faxNumber;
  dynamic banker;
  dynamic contactPerson;
  dynamic comment;
  String? clientRef;
  dynamic currencyLimit;
  dynamic currency;
  dynamic sample;
  dynamic billto;
  dynamic partyname;
  dynamic partygstin;
  dynamic customerUniqueId;
  dynamic localRefNumber;
  dynamic localReportRefNumber;
  dynamic reportTypeRequired;
  dynamic reportTypeDelivered;
  dynamic reportFrequency;
  dynamic paymentCurrency;
  dynamic paymentMode;
  String? requestStatus;
  dynamic cancelBy;
  dynamic cancelDate;
  DateTime? orderDate;
  dynamic reportDateOfDelivery;
  DateTime? reportDeliveryDate;
  String? finalDeliveryDate;
  String? deliveryTime;
  dynamic hardcopy;
  DateTime? createdDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  dynamic address3;
  dynamic address2;
  String? requestMode;
  String? salesAgentCode;
  dynamic contactPersonNumber;
  dynamic clientReferenceName;
  dynamic clientContactPerson;
  dynamic bankDetails;
  dynamic tradeName;
  int? status;
  dynamic alternateNumber;
  dynamic tradeLicenceNumber;
  dynamic website;
  dynamic emailId;
  dynamic requestLocality;
  dynamic reportType;
  dynamic reportSpeed;
  dynamic subjectCode;
  String? qcAssign;
  String? legalFrom;
  dynamic dpCode;

  factory Getrequest.fromJson(Map<String, dynamic> json) => Getrequest(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"],
        requestBy: json["request_by"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        loginId: json["login_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        country: json["country"] == null ? null : json["country"],
        address1: json["address1"] == null ? null : json["address1"],
        city: json["city"],
        pinCode: json["pin_code"],
        gst: json["gst"],
        pan: json["pan"] == null ? null : json["pan"],
        vat: json["vat"],
        cst: json["cst"],
        regNumber: json["reg_number"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        mobile: json["mobile"],
        faxNumber: json["fax_number"],
        banker: json["banker"],
        contactPerson: json["contact_person"],
        comment: json["comment"],
        clientRef: json["client_ref"] == null ? null : json["client_ref"],
        currencyLimit: json["currency_limit"],
        currency: json["currency"],
        sample: json["sample"],
        billto: json["billto"],
        partyname: json["partyname"],
        partygstin: json["partygstin"],
        customerUniqueId: json["customer_unique_id"],
        localRefNumber: json["local_ref_number"],
        localReportRefNumber: json["local_report_ref_number"],
        reportTypeRequired: json["report_type_required"],
        reportTypeDelivered: json["report_type_delivered"],
        reportFrequency: json["report_frequency"],
        paymentCurrency: json["payment_currency"],
        paymentMode: json["payment_mode"],
        requestStatus:
            json["request_status"] == null ? null : json["request_status"],
        cancelBy: json["cancel_by"],
        cancelDate: json["cancel_date"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        reportDateOfDelivery: json["report_date_of_delivery"],
        reportDeliveryDate: json["report_delivery_date"] == null
            ? null
            : DateTime.parse(json["report_delivery_date"]),
        finalDeliveryDate: json["final_delivery_date"] == null
            ? null
            : json["final_delivery_date"],
        deliveryTime:
            json["delivery_time"] == null ? null : json["delivery_time"],
        hardcopy: json["hardcopy"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        address3: json["address3"],
        address2: json["address2"],
        requestMode: json["request_mode"] == null ? null : json["request_mode"],
        salesAgentCode:
            json["sales_agent_code"] == null ? null : json["sales_agent_code"],
        contactPersonNumber: json["contact_person_number"],
        clientReferenceName: json["client_reference_name"],
        clientContactPerson: json["client_contact_person"],
        bankDetails: json["bank_details"],
        tradeName: json["trade_name"],
        status: json["status"] == null ? null : json["status"],
        alternateNumber: json["Alternate_number"],
        tradeLicenceNumber: json["trade_licence_number"],
        website: json["website"],
        emailId: json["email_id"],
        requestLocality: json["request_locality"],
        reportType: json["report_type"],
        reportSpeed: json["report_speed"],
        subjectCode: json["subject_code"],
        qcAssign: json["qc_assign"] == null ? null : json["qc_assign"],
        legalFrom: json["legal_from"] == null ? null : json["legal_from"],
        dpCode: json["dp_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "request_id": requestId,
        "request_by": requestBy,
        "customer_id": customerId == null ? null : customerId,
        "branch_id": branchId == null ? null : branchId,
        "login_id": loginId,
        "order_id": orderId == null ? null : orderId,
        "company_name": companyName == null ? null : companyName,
        "company_id": companyId == null ? null : companyId,
        "country": country == null ? null : country,
        "address1": address1 == null ? null : address1,
        "city": city,
        "pin_code": pinCode,
        "gst": gst,
        "pan": pan == null ? null : pan,
        "vat": vat,
        "cst": cst,
        "reg_number": regNumber,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "mobile": mobile,
        "fax_number": faxNumber,
        "banker": banker,
        "contact_person": contactPerson,
        "comment": comment,
        "client_ref": clientRef == null ? null : clientRef,
        "currency_limit": currencyLimit,
        "currency": currency,
        "sample": sample,
        "billto": billto,
        "partyname": partyname,
        "partygstin": partygstin,
        "customer_unique_id": customerUniqueId,
        "local_ref_number": localRefNumber,
        "local_report_ref_number": localReportRefNumber,
        "report_type_required": reportTypeRequired,
        "report_type_delivered": reportTypeDelivered,
        "report_frequency": reportFrequency,
        "payment_currency": paymentCurrency,
        "payment_mode": paymentMode,
        "request_status": requestStatus == null ? null : requestStatus,
        "cancel_by": cancelBy,
        "cancel_date": cancelDate,
        "order_date": orderDate == null
            ? null
            : "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "report_date_of_delivery": reportDateOfDelivery,
        "report_delivery_date": reportDeliveryDate == null
            ? null
            : "${reportDeliveryDate!.year.toString().padLeft(4, '0')}-${reportDeliveryDate!.month.toString().padLeft(2, '0')}-${reportDeliveryDate!.day.toString().padLeft(2, '0')}",
        "final_delivery_date":
            finalDeliveryDate == null ? null : finalDeliveryDate,
        "delivery_time": deliveryTime == null ? null : deliveryTime,
        "hardcopy": hardcopy,
        "created_date":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "created_by": createdBy == null ? null : createdBy,
        "updated_date":
            updatedDate == null ? null : updatedDate!.toIso8601String(),
        "updated_by": updatedBy == null ? null : updatedBy,
        "address3": address3,
        "address2": address2,
        "request_mode": requestMode == null ? null : requestMode,
        "sales_agent_code": salesAgentCode == null ? null : salesAgentCode,
        "contact_person_number": contactPersonNumber,
        "client_reference_name": clientReferenceName,
        "client_contact_person": clientContactPerson,
        "bank_details": bankDetails,
        "trade_name": tradeName,
        "status": status == null ? null : status,
        "Alternate_number": alternateNumber,
        "trade_licence_number": tradeLicenceNumber,
        "website": website,
        "email_id": emailId,
        "request_locality": requestLocality,
        "report_type": reportType,
        "report_speed": reportSpeed,
        "subject_code": subjectCode,
        "qc_assign": qcAssign == null ? null : qcAssign,
        "legal_from": legalFrom == null ? null : legalFrom,
        "dp_code": dpCode,
      };
}

NoDataFound noDataFoundFromJson(String str) =>
    NoDataFound.fromJson(json.decode(str));

String noDataFoundToJson(NoDataFound data) => json.encode(data.toJson());

class NoDataFound {
  NoDataFound({
    this.data,
    this.length,
    this.msg,
  });

  dynamic data;
  int? length;
  String? msg;

  factory NoDataFound.fromJson(Map<String, dynamic> json) => NoDataFound(
        data: json["data"],
        length: json["length"] == null ? null : json["length"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "length": length == null ? null : length,
        "msg": msg == null ? null : msg,
      };
}

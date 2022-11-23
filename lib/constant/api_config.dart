import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static String? prop;

  static const String baseurl = "https://codeapi.mnscredit.in/api";

  static const String billingCustomer =
      "$baseurl/Billing_customer?slug={%22status%22:1}&relation=[%22Mobile_number%22]";
  static const String pendingOrder =
      "$baseurl/orders/%7B%22order_status%22:%22All%22,%22start_date%22:%222022-7-20%22,%22end_date%22:%222022-07-30%22,%22Complete%22:%22Complete%22%7D?relation=[%22Getcustomer%22,%22GetBranch%22,%22GetreportName%22,%22Getrequest%22,%22Getpartyname%22,%22Getcountry%22,%22Getspocall%22,%22Getinvoice%22]";

  static const String orderListApi =
      "$baseurl/marketing_orders/%7B%22order_status%22:%22All%22,%22start_date%22:%222022-07-04%22,%22end_date%22:%222022-07-19%22%7D?relation=[%22Getcustomer%22,%22GetBranch%22,%22GetreportName%22,%22Getrequest%22,%22Getpartyname%22,%22Getcountry%22,%22Getinvoice%22]";

  static const String newOrderReq = "$baseurl/request?slug={%22status%22:1}";

  static const String followLead = "$baseurl/follow/";
  static const String customerList = "$baseurl/Customer/%7B%22status%22:1%7D";

  static const String newOrder = "$baseurl/request";
  static const String qcList =
      "$baseurl/qc/%7B%22status%22:1,%22department%22:%22QC%22%7D?column=[%22id%22,%22name%22]";
  static const String branchList = "$baseurl/Branch/";
  static const String reportName =
      "$baseurl/Report_types?slug=%7B%22status%22:1%7D";
  static const String agentList = "$baseurl/sales_team";

  static const String countryList = "$baseurl/country/";
  static const String leadList = "$baseurl/follow/";
  static const String partyList = "$baseurl/SearchApi/";
  static const String branchSpoke = "$baseurl/Branch_spocs/";
  static const String loginUrl = "$baseurl/login";
  static const String deliveryData = "$baseurl/tatApi/";
  static const String searchApi = "$baseurl/SearchApi/";
  static const String followAdd = "$baseurl/follow";
  static const String companySearch = "$baseurl/searchcompany/";
  static const String companyData = "$baseurl/company/";
  static const String spokeaddRequest = "$baseurl/Branch_spocs";
}

// this.form.submit('get', `${this.$domain_name}/api/searchcompany/${value}/company_name`).then((success) => {

  
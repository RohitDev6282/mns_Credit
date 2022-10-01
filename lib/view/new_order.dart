import 'dart:async';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/companylist.dart';
import 'package:mns_management/modals/partyname_model.dart';
import 'package:mns_management/respository/company_name.dart';
import 'package:mns_management/respository/party_list.dart';
import 'package:mns_management/view/footer.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/loader.dart';
import 'package:mns_management/widget/textfiled.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/string.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({
    Key? key,
    // required GlobalKey<ScaffoldState> parentScaffoldKey,
    // RouteArgument? routeArgument
  }) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  void initState() {
    super.initState();
    getqc();
    _getCustomer();
    getAgent();
    getCountry();
    getReportName();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Timer? debouncer;

  bool isSelected = false;
  bool value = false;
  bool imageUpload2 = false;
  bool imageUpload3 = false;
  bool imageUpload4 = false;
  bool imageUpload5 = false;
  bool discountCheck = false;
  bool message = false;
  bool ackno = false;
  bool report = false;
  bool source = false;
  bool source1 = false;
  bool isBranch = false;
  bool isLoading = false;
  bool visibilty = false;
  bool visibilty1 = true;
  bool visbility2 = false;
  bool readable = false;
  bool waiting = true;

  String discountType = "0";
  String finalId = "";
  String gstNo = "GST Number";
  String partyName = "Party Name";
  String query = "";
  String deliveryType = "Select the report";
  String party = "self";
  String discounttype = "0";
  String? partyNameId;
  String reportval = "0";
  String selectDiscount = "0";
  String? soucrce;
  String? selectCountry;
  String companyId = "";

// List of items in our dropdown menu
  List<String> reportName = [
    'Normal',
    'Express',
    'Super Express',
  ];
  DateTime sltdelivery = DateTime.now();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String fetchdeliverydate = "Delivery Date";
  var orderDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());

  List<dynamic> fetchCustomer = [];
  List<dynamic> fetchBranch = [];
  List<dynamic> fetchCountry = [];
  List<dynamic> fetchAgent = [];
  List<dynamic> fetchreporttype = [];
  List<dynamic> fetchQc = [];
  List agent = [];
  List<dynamic> countryList = [];
  List state = [];
  List<dynamic> fetchCutomer = [];
  List selectedReportIndexes = [];
  List<PartyListModel> fetchParty = [];
  List<dynamic> fetchspokPrsn = [];
  List selectedIndexes = [];
  var spokePersonDetail = [];
  List ackonow = [];
  List fetchCompanyData = [];

  var fetchDeliveryDay;
  var fetchDeliveryRegion;
  var selectAgentName;
  var selectQc;
  var selectCustomer;
  var selectBranch;

  var selectreportName;
  var selectReportType;
  var _selectState;
  var _selectCity;
  var jsonstringfy;
  var spokeID;
  var file;
  var file1;
  var file2;
  var file3;
  var file4;

  final formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _alternateAddress = TextEditingController();
  final TextEditingController _dpCode = TextEditingController();
  final TextEditingController _concernPersonName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _alternateNumber = TextEditingController();
  final TextEditingController _faxNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _website = TextEditingController();
  final TextEditingController _tradeName = TextEditingController();
  final TextEditingController _tradeLicenceNumber = TextEditingController();
  final TextEditingController _bankDetail = TextEditingController();
  final TextEditingController _panNumber = TextEditingController();
  final TextEditingController _gst = TextEditingController();
  final TextEditingController _vatNumber = TextEditingController();
  final TextEditingController _registrationNumber = TextEditingController();
  final TextEditingController _cstRegNo = TextEditingController();
  final TextEditingController _clientReferenceNo = TextEditingController();
  final TextEditingController _clientRefName = TextEditingController();
  final TextEditingController _clientContactPerson = TextEditingController();
  final TextEditingController _subCode = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _partyName = TextEditingController();
  final TextEditingController controller = TextEditingController();

  Future getAgent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var myKey = preferences.getString("token") ?? "";
    String queryuri = Config.agentList;
    var header = {
      'mykey': myKey,
    };
    var response = await http.get(Uri.parse(queryuri), headers: header);
    var data = jsonDecode(
      response.body,
    );
    List list = json.decode(data["data"]);
    setState(() {
      fetchAgent = list;
    });

    return "sucess";
  }

  Future getCompanyData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var myKey = preferences.getString("token") ?? "";
    String queryuri = Config.companyData + companyId;
    var header = {
      'mykey': myKey,
    };
    var response = await http.get(Uri.parse(queryuri), headers: header);
    var data = jsonDecode(
      response.body,
    );

    var list = data["data"] as List;

    for (var i = 0; i < list.length; i++) {
      fetchCompanyData = list;

      _companyName.text = fetchCompanyData[0]["company_name"] ?? "";
      _address.text = fetchCompanyData[0]["getrequest"]["address1"] ?? "";
      _alternateAddress.text =
          fetchCompanyData[0]["getrequest"]["address2"] ?? "";
      _dpCode.text = fetchCompanyData[0]["getrequest"]["dp_code"] ?? "";
      _concernPersonName.text =
          fetchCompanyData[0]["getrequest"]["client_contact_person"] ?? "";
      _phoneNumber.text =
          fetchCompanyData[0]["getrequest"]["phone_number"] ?? "";
      _mobileNumber.text = fetchCompanyData[0]["getrequest"]["mobile"] ?? "";
      _alternateNumber.text =
          fetchCompanyData[0]["getrequest"]["Alternate_number"] ?? "";
      _faxNo.text = fetchCompanyData[0]["getrequest"]["fax_number"] ?? "";
      _email.text = fetchCompanyData[0]["getrequest"]["email_id"] ?? "";
      _website.text = fetchCompanyData[0]["getrequest"]["website"] ?? "";

      _tradeName.text = fetchCompanyData[0]["getrequest"]["trade_name"] ?? "";
      _tradeLicenceNumber.text =
          fetchCompanyData[0]["getrequest"]["trade_licence_number"] ?? "";
      _bankDetail.text =
          fetchCompanyData[0]["getrequest"]["bank_details"] ?? "";

      _panNumber.text = fetchCompanyData[0]["getrequest"]["pan"] ?? "";
      _gst.text = fetchCompanyData[0]["getrequest"]["gst"] ?? "";
      _vatNumber.text = fetchCompanyData[0]["getrequest"]["vat"] ?? "";
      _registrationNumber.text = fetchCompanyData[0]["reg_no"] ?? "";
      _cstRegNo.text = fetchCompanyData[0]["getrequest"]["cst"] ?? "";
      _clientReferenceNo.text = fetchCompanyData[0]["cleint_ref"] ?? "";
      _clientRefName.text =
          fetchCompanyData[0]["getrequest"]["client_reference_name"] ?? "";

      _clientContactPerson.text =
          fetchCompanyData[0]["getrequest"]["client_contact_person"] ?? "";
      _subCode.text = fetchCompanyData[0]["getrequest"]["subject_code"] ?? "";

      return "sucess";
    }
  }

  Future getSpokePersonList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    String url = Config.branchSpoke;
    Map<String, String> queryParams = {
      "branch_id": selectBranch.toString(),
      "status": "1"
    };
    String jsonString = json.encode(queryParams);
    String request = Uri.encodeFull(jsonString);
    var header = {
      'mykey': myKey,
    };
    var response = await http.get(Uri.parse(url + request), headers: header);
    var data = json.decode(response.body);
    setState(() {
      fetchspokPrsn = jsonDecode(data["data"]);
    });
    return "sucess";
  }

  Future getqc() async {
    String queryuri = Config.qcList;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var myKey = preferences.getString("token") ?? "";

    var header = {'mykey': myKey};
    var response = await http.get(Uri.parse(queryuri), headers: header);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var list = jsonDecode(data["data"]);
      setState(() {
        fetchQc = list;
      });
      return "sucess";
    } else {
      throw Exception('Failed to load api');
    }
  }

  Future getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Map<String, String> queryParams = {"status": "1"};
    // String jsonString = json.encode(queryParams);
    // String country_list = Uri.encodeFull(jsonString);
    var myKey = preferences.getString("token") ?? "";

    var headers = {'mykey': myKey};
    String url =
        Config.countryList + '%7B"status":1%7D?column=["id","country_name"]';
    var response = await http.get(Uri.parse(url), headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(data["data"]);

      setState(() {
        fetchCountry = list;
      });

      return "sucess";
    }
  }

  Future getDeliveydate() async {
    String queryuri = Config.deliveryData;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> queryParams = {
      "customer_id": selectCustomer,
      "country_id": selectCountry,
      "report_id": "$selectReportType",
      "delivery_type": deliveryType
    };
    String jsonString = json.encode(queryParams);
    String request = Uri.encodeFull(jsonString);
    var myKey = preferences.getString("token") ?? "";
    var header = {'mykey': myKey};
    String url = queryuri + request;
    var response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var list = jsonDecode(data["data"]);
      setState(() {
        fetchDeliveryDay = list["day"];
        fetchDeliveryRegion = list["region"];
        fetchdeliverydate = list["delivery_date"];
      });
      return "sucess";
    }
  }

  Future _getCustomer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    var headers = {'mykey': myKey};
    var response =
        await http.get(Uri.parse(Config.customerList), headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
      var data = json.decode(response.body);

      var list = jsonDecode(data["data"]);

      setState(() {
        fetchCustomer = list;
      });
      return fetchCustomer;
    } else if (response.statusCode == 401) {
      var data = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(data["notice"].toString()),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Future getBranch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    String url = Config.branchList;
    final queryParams = '"customer_id": $selectCustomer';
    Map valueMap = json.decode(myKey);
    var loginId = valueMap["id"];
    var slug = '"status":1,"login_id":$loginId';
    var request = url + "{$queryParams,$slug}";

    var headers = {'mykey': myKey};
    var response = await http.get(Uri.parse(request), headers: headers);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(data["data"]);
      list.forEach((element) {});
      setState(() {
        fetchBranch = list;
      });

      return "sucess";
    }
  }

  Future getReportName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    var headers = {'mykey': myKey};
    var response =
        await http.get(Uri.parse(Config.reportName), headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var list = jsonDecode(data["data"]);
      list.forEach((element) {});
      setState(() {
        fetchreporttype = list;
      });

      return "sucess";
    } else {
      throw Exception('Failed to api data');
    }
  }

  Future<File> getImage0() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(image?.path ?? "No image selected");
    });

    return file!;
  }

  Future<File> getImage1() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    file1 = File(image?.path ?? "No image selected");

    return file1!;
  }

  Future<File> getImage2() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      file2 = File(image?.path ?? "No image selected");
    });

    return file2!;
  }

  Future<File> getImage3() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      file3 = File(image?.path ?? "No image selected");
    });
    return file3!;
  }

  Future<File> getImage4() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file4 = File(image?.path ?? "No image selected");
    });
    return file4!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kSecondaryColor, title: const Text("Add New Order")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const [
                    Text(
                      'Select Agent',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(
                  height: smlheight,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      hint: const Text(
                        "-- Please Select the Agent --",
                        style: kMediumTextStyle,
                      ),
                      validator: (value) =>
                          value == null ? 'Select the Agent' : null,
                      value: selectAgentName,
                      isExpanded: true,
                      items: fetchAgent.map((val) {
                        return DropdownMenuItem(
                          value:
                              "${val["username"][0].toUpperCase()}${val["username"][1]}-${val["id"]}",
                          child: Text(
                            val["username"],
                            style: kLTextStyle,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectAgentName = value;
                        });
                        (value) {
                          if (value == null) {
                            return 'Select the Agent';
                          }
                        };
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: dxxlheight,
                ),
                Row(
                  children: const [
                    Text(
                      'Select Qc',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(
                  height: smlheight,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      validator: (value) =>
                          value == null ? 'Select the qc' : null,
                      hint: const Text(
                        "MNSQC",
                        style: kMediumTextStyle,
                      ),
                      value: selectQc,
                      onChanged: (newValue) {
                        setState(() {
                          selectQc = newValue;
                        });
                      },
                      isExpanded: true,
                      items: fetchQc.map((val) {
                        return DropdownMenuItem(
                          value: val["id"],
                          child: Text(
                            val["name"],
                            style: kBMTextStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: dxxlheight,
                ),
                Row(
                  children: const [
                    Text(
                      'Customer',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(
                  height: smlheight,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: DropdownSearch<dynamic>(
                    validator: (value) {
                      if (value == null) return 'select the Customer';

                      return null;
                    },
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                    autoValidateMode: AutovalidateMode.always,
                    mode: Mode.DIALOG,
                    items: fetchCustomer
                        .map(
                          (e) => e["customer_name"],
                        )
                        .toList(),
                    dropdownSearchDecoration: InputDecoration(
                        icon: fetchCustomer.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Loader(
                                  height: 20,
                                  width: 20,
                                ),
                              )
                            : null,
                        hintStyle: kMediumTextStyle,
                        helperStyle: kMediumTextStyle,
                        floatingLabelStyle: kMediumTextStyle,
                        hintText: "Select the Customer",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12)),
                    onChanged: (newValue) {
                      setState(() {
                        selectCustomer = fetchCustomer
                            .singleWhere(
                                (e) => e['customer_name'] == newValue)['id']
                            .toString();
                        isBranch = true;
                        getBranch();
                      });
                    },
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(
                  height: dxxlheight,
                ),
                Row(
                  children: const [
                    Text(
                      'Branch',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(
                  height: smlheight,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: DropdownSearch<dynamic>(
                    validator: (value) {
                      if (value == null) return 'select the Branch';

                      return null;
                    },
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                    autoValidateMode: AutovalidateMode.always,
                    mode: Mode.DIALOG,
                    items: fetchBranch
                        .map(
                          (e) => e["branch_name"],
                        )
                        .toList(),
                    dropdownSearchDecoration: InputDecoration(
                        icon: isBranch
                            ? fetchBranch.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Loader(
                                      height: 20,
                                      width: 20,
                                    ),
                                  )
                                : null
                            : null,
                        counterStyle: kMediumTextStyle,
                        hintText: "Select the Branch",
                        hintStyle: kMediumTextStyle,
                        helperStyle: kMediumTextStyle,
                        floatingLabelStyle: kMediumTextStyle,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12)),
                    onChanged: (newValue) {
                      setState(() {
                        selectBranch = fetchBranch
                            .singleWhere(
                                (e) => e['branch_name'] == newValue)['id']
                            .toString();
                        readable = true;
                        getSpokePersonList();
                      });
                    },
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(
                  height: smlheight,
                ),
                const SizedBox(
                  height: height,
                ),
                readable == true
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Column(children: [
                                const SizedBox(
                                  child: Text(
                                    spokePersnF1,
                                    style: kBLTextStyle,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: fetchspokPrsn.length,
                                    itemBuilder: (context, index) {
                                      spokePersonDetail.add({
                                        "spoc_id": fetchspokPrsn[index]["id"],
                                        "ack": 0,
                                        "report": 0,
                                        "spoc_name": fetchspokPrsn[index]
                                            ["spoc_name"],
                                        "spoc_mobile": fetchspokPrsn[index]
                                            ["spoc_phone"],
                                        "spoc_email": fetchspokPrsn[index]
                                            ["spoc_email"],
                                      });
                                      return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 5),
                                          child: FittedBox(
                                              child: SizedBox(
                                            height: 21.9,
                                            child: Checkbox(
                                              value: selectedIndexes
                                                  .contains(index),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  ackno = value!;
                                                });

                                                if (selectedIndexes
                                                    .contains(index)) {
                                                  selectedIndexes.remove(index);

                                                  setState(() {
                                                    spokeID = index;
                                                    spokePersonDetail[index]
                                                        ["ack"] = 0;
                                                  });
                                                } else {
                                                  selectedIndexes.add(index);
                                                  setState(() {
                                                    spokeID = index;
                                                    spokePersonDetail[index]
                                                        ["ack"] = 1;
                                                  });
                                                }
                                              },
                                              checkColor: kWhiteColor,
                                              activeColor: kSecondaryColor,
                                            ),
                                          )));
                                    })
                              ]),
                            ),
                            const SizedBox(
                              width: height,
                            ),
                            SizedBox(
                              width: 50,
                              child: Column(children: [
                                const SizedBox(
                                  child: Text(
                                    spokePersnF2,
                                    style: kBLTextStyle,
                                  ),
                                ),
                                Column(
                                    children: List.generate(
                                        fetchspokPrsn.length, (index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: FittedBox(
                                      child: SizedBox(
                                        height: 21.9,
                                        child: Checkbox(
                                          value: selectedReportIndexes
                                              .contains(index),
                                          onChanged: (bool? value) {
                                            if (selectedReportIndexes
                                                .contains(index)) {
                                              selectedReportIndexes
                                                  .remove(index);
                                              // unselect

                                              setState(() {
                                                spokeID = index;
                                                spokePersonDetail[index]
                                                    ["report"] = 0;
                                              });
                                            } else {
                                              selectedReportIndexes.add(index);
                                              setState(() {
                                                spokeID = index;
                                                spokePersonDetail[index]
                                                    ["report"] = 1;
                                              }); // select

                                            }
                                          },
                                          checkColor: kWhiteColor,
                                          activeColor: kSecondaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                              ]),
                            ),
                            const SizedBox(
                              width: height,
                            ),
                            SizedBox(
                              width: 200,
                              child: Column(children: [
                                const SizedBox(
                                  child: Text(
                                    spokePersnF3,
                                    style: kBLTextStyle,
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: fetchspokPrsn
                                        .map((i) => Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 4, 5, 4.3),
                                              child: SizedBox(
                                                  height: 20,
                                                  child: Text(i["spoc_name"])),
                                            ))
                                        .toList())
                              ]),
                            ),
                            const SizedBox(
                              width: height,
                            ),
                            Column(children: [
                              const SizedBox(
                                child: Text(
                                  spokePersnF4,
                                  style: kBLTextStyle,
                                ),
                              ),
                              Column(
                                  children: fetchspokPrsn
                                      .map((i) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 4, 5, 4.3),
                                            child: SizedBox(
                                                height: 20,
                                                child: Text(i["spoc_email"])),
                                          ))
                                      .toList())
                            ]),
                            const SizedBox(
                              width: height,
                            ),
                            Column(children: [
                              const SizedBox(
                                child: Text(
                                  spokePersnF5,
                                  style: kBLTextStyle,
                                ),
                              ),
                              Column(
                                  children: fetchspokPrsn
                                      .map((i) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 4, 5, 4.3),
                                            child: SizedBox(
                                              height: 20,
                                              child: Text(
                                                  i["spoc_phone"].toString()),
                                            ),
                                          ))
                                      .toList())
                            ]),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: dxxlheight,
                ),
                Row(
                  children: const [
                    Text(
                      'Country',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: DropdownSearch<dynamic>(
                    validator: (value) {
                      if (value == null) return 'select the Country';

                      return null;
                    },
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                    autoValidateMode: AutovalidateMode.always,
                    mode: Mode.DIALOG,
                    items: fetchCountry
                        .map(
                          (e) => e['country_name'],
                        )
                        .toList(),
                    dropdownSearchDecoration: InputDecoration(
                        icon: fetchCountry.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Loader(
                                  height: 20,
                                  width: 20,
                                ),
                              )
                            : null,
                        hintStyle: kMediumTextStyle,
                        helperStyle: kMediumTextStyle,
                        floatingLabelStyle: kMediumTextStyle,
                        hintText: "Select the Country",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12)),
                    onChanged: (newValue) {
                      setState(() {
                        selectCountry = fetchCountry
                            .singleWhere(
                                (e) => e['country_name'] == newValue)['id']
                            .toString();
                      });
                    },
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(
                  height: height,
                ),
                Row(
                  children: const [
                    Text(
                      'Company Name',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(
                  height: smlheight,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TypeAheadFormField<CompanyListModel?>(
                    hideOnEmpty: true,
                    minCharsForSuggestions: 4,
                    hideSuggestionsOnKeyboardHide: false,
                    debounceDuration: const Duration(milliseconds: 500),
                    suggestionsCallback: (query) async {
                      if (query.isEmpty) return [];
                      return await getCompanyList(query);
                    },
                    itemBuilder: (context, CompanyListModel? suggestion) {
                      final user = suggestion!;
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            user.companyName.toString(),
                            style: kMediumTextStyle,
                          ),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _companyName.text = suggestion!.companyName.toString();
                      companyId = suggestion.id.toString();
                      getCompanyData();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill company name';
                      }
                      return null;
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _companyName,
                      style: kBLTextStyle,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                        hintText: "Search the Company Name",
                        hintStyle: ktextFieldText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: height,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.streetAddress,
                    validiate: (value) =>
                        value == null ? 'Please fill the Address' : null,
                    hinttest: "",
                    label: Row(
                      children: const [
                        Text(
                          'Address',
                        ),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                        ),
                        Text('*', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    controller: _address),
                const SizedBox(height: 16),
                TextFieldWidget(
                    validiate: (value) {
                      if (selectCustomer == "6") {
                        value != null;
                        return "Dp code is Required";
                      }
                    },
                    keyType: TextInputType.streetAddress,
                    hinttest: "",
                    label: const Text(
                      'Alternate Address',
                    ),
                    controller: _alternateAddress),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.text,
                    hinttest: "",
                    label: const Text("Dp Code"),
                    controller: _dpCode),
                const SizedBox(height: 16),
                TextFieldWidget(
                    keyType: TextInputType.name,
                    hinttest: "",
                    label: const Text("Concern Person Name"),
                    controller: _concernPersonName),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "",
                    label: const Text("Phone Number"),
                    controller: _phoneNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "",
                    label: const Text("Mobile Number"),
                    controller: _mobileNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "",
                    label: const Text("Alternate Number"),
                    controller: _alternateNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "",
                    label: const Text("Fax No."),
                    controller: _faxNo),
                const SizedBox(height: 20),
                TextFieldWidget(
                    keyType: TextInputType.emailAddress,
                    hinttest: "",
                    label: const Text("Email ID"),
                    controller: _email),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Website"),
                    controller: _website),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Trade Name"),
                    controller: _tradeName),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Trade licence Number"),
                    controller: _tradeLicenceNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Bank Detail"),
                    controller: _bankDetail),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Pan"),
                    controller: _panNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Gst NUmber"),
                    controller: _gst),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Vat Number"),
                    controller: _vatNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Registration Number/Cin Number"),
                    controller: _registrationNumber),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Cst Regn No."),
                    controller: _cstRegNo),
                const SizedBox(height: 20),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "",
                    label: const Text("Client Ref No."),
                    controller: _clientReferenceNo),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Client Reference Name"),
                    controller: _clientRefName),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Client Contact Person"),
                    controller: _clientContactPerson),
                const SizedBox(height: 20),
                TextFieldWidget(
                    hinttest: "",
                    label: const Text("Subject Code/Client Code"),
                    controller: _subCode),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      'Report Type',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: smlheight),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton(
                      hint: const Text(
                        "select the report Type",
                        style: kMediumTextStyle,
                      ),
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      isExpanded: true,
                      items: fetchreporttype.map((val) {
                        return DropdownMenuItem(
                          child: Text(
                            val["report_type"],
                            style: kMediumTextStyle,
                          ),
                          value: val['id'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectReportType = value;
                        });
                      },
                      value: selectReportType,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Text(
                      'Report ',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: smlheight),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButton(
                      hint: Text(
                        deliveryType,
                        style: kMediumTextStyle,
                      ),
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      isExpanded: true,
                      style: kMediumTextStyle,
                      items: ['Normal', 'Express', 'Super Express'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) {
                        setState(
                          () {
                            getDeliveydate();
                            message = true;
                            deliveryType = val!;
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: height,
                ),
                const Text(
                  "Order Date",
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: kLightGreyColor)],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(26, 18, 4, 18),
                      hintText: orderDate,
                      hintStyle: kBLTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: kWhiteColor, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: kWhiteColor, width: 0.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Delivery Date",
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: kLightGreyColor)],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          sltdelivery = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100))) ??
                              DateTime.now();
                          // dateCtl.text = dateFormat.format(sltdelivery);
                        },
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(26, 18, 4, 18),
                      hintText: fetchdeliverydate,
                      hintStyle: kMediumTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: kWhiteColor, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: kWhiteColor, width: 0.0),
                      ),
                    ),
                  ),
                ),
                message
                    ? (Text(
                        fetchDeliveryDay.toString() +
                            " Working DayAdded" +
                            fetchDeliveryRegion.toString(),
                        style: kLCAtStyle,
                      ))
                    : Container(),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      'Comment',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: smlheight),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: kLightGreyColor)],
                  ),
                  child: TextFormField(
                      controller: _comment,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(26, 18, 4, 18),
                        hintText: "Enter the Comment",
                        hintStyle: kMediumTextStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: kWhiteColor, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: kWhiteColor, width: 0.0),
                        ),
                      ),
                      onTap: () {}),
                ),
                Row(
                  children: [
                    const Text(
                      "Discount Type",
                      style: kLabelTextStyle,
                    ),
                    Checkbox(
                      value: value,
                      onChanged: (bool? val) {
                        setState(() {
                          value = val!;
                          discountType = "1";
                          if (value == false) {
                            discountType = "0";
                          }
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Source Disclose',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: smlheight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => kSecondaryColor),
                              value: "1",
                              groupValue: soucrce,
                              onChanged: (value) {
                                setState(() {
                                  source = true;
                                  soucrce = "1";
                                  source1 = false;
                                });
                              }),
                          const Expanded(
                            child: Text('Yes'),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => kSecondaryColor),
                              value: '0',
                              groupValue: soucrce,
                              onChanged: (value) {
                                setState(() {
                                  source1 = true;
                                  soucrce = "0";
                                  source = false;
                                });
                              }),
                          const Expanded(
                            child: Text('No'),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text(
                      'Please Select Party Type',
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: smlheight),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => kSecondaryColor),
                              value: 'self',
                              groupValue: party,
                              onChanged: (value) {
                                setState(() {
                                  visibilty = false; //spoke person visibitliy

                                  visibilty1 = true;
                                  party = "self";
                                  visbility2 = false;
                                });
                              }),
                          const Expanded(
                            child: Text('Self'),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => kSecondaryColor),
                              value: 'billto',
                              groupValue: party,
                              onChanged: (value) {
                                setState(() {
                                  visibilty = true; //spoke person det  ail true
                                  visbility2 = true;
                                  party = "billto";
                                  visibilty1 = false;
                                });
                              }),
                          const Expanded(child: Text('Bill To'))
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                visibilty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Party Name',
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                              ),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: kLightGreyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: TypeAheadFormField<PartyListModel?>(
                              hideOnEmpty: true,
                              minCharsForSuggestions: 4,
                              hideSuggestionsOnKeyboardHide: false,
                              debounceDuration:
                                  const Duration(milliseconds: 500),
                              suggestionsCallback: (query) async {
                                if (query.isEmpty) return [];
                                return await getPartyList(query);
                              },
                              itemBuilder:
                                  (context, PartyListModel? suggestion) {
                                final user = suggestion!;
                                return SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.billingPartyName.toString(),
                                      style: kMediumTextStyle,
                                    ),
                                  ),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                _partyName.text =
                                    suggestion!.billingPartyName.toString();
                                partyName =
                                    suggestion.billingPartyName.toString();
                                partyNameId = suggestion.id.toString();
                                gstNo = suggestion.gst.toString();
                                partyNameId = suggestion.id.toString();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select the party Name';
                                }
                                return null;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: _partyName,
                                style: kBLTextStyle,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(26, 18, 4, 18),
                                  hintText: "Search the Company Name",
                                  hintStyle: ktextFieldText,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Gst Number",
                            style: kMediumTextStyle,
                          ),
                          const SizedBox(
                            height: height,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: kLightGreyColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  gstNo,
                                  style: kBLTextStyle,
                                ),
                              )),
                          const SizedBox(
                            height: height,
                          ),
                        ],
                      )
                    : Container(),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        getImage0();
                        setState(() {
                          // imageUpload2 = true;
                        });
                      },
                    ),
                    file != null
                        ? Text(
                            file
                                .toString()
                                .substring(70, file.toString().length),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          )
                        : const Text("PLease Upload Image")
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        setState(() {
                          getImage1();
                          // imageUpload3 == true;
                        });
                      },
                    ),
                    file1 != null
                        ? Text(
                            file2
                                .toString()
                                .substring(70, file1.toString().length),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          )
                        : const Text("PLease Upload Image"),
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        setState(() {
                          getImage2();
                          // imageUpload4 == true;
                        });
                      },
                    ),
                    file2 != null
                        ? Text(
                            file2
                                .toString()
                                .substring(70, file2.toString().length),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const Text("PLease Upload Image")
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        getImage3();
                        // imageUpload5 == true;
                      },
                    ),
                    file3 != null
                        ? Text(
                            file3
                                .toString()
                                .substring(70, file2.toString().length),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          )
                        : const Text("PLease Upload Image")
                  ],
                ),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        getImage4();
                      },
                    ),
                    file4 != null
                        ? Text(
                            file4
                                .toString()
                                .substring(70, file4.toString().length),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          )
                        : const Text("PLease Upload Image")
                  ],
                ),
                Center(
                  child: CustomButton(
                    text: "Submit",
                    colors: kSecondaryColor,
                    onTap: () {
                      spokePersonDetail.removeWhere(
                          (item) => item["ack"] == 0 && item["report"] == 0);
                      jsonstringfy = jsonEncode(spokePersonDetail);

                      if (formKey.currentState!.validate()) {
                        newOrder(
                            _companyName.text,
                            _address.text,
                            _alternateAddress.text,
                            _dpCode.text,
                            _concernPersonName.text,
                            _phoneNumber.text,
                            _mobileNumber.text,
                            _alternateNumber.text,
                            _faxNo.text,
                            _email.text,
                            _website.text,
                            _tradeName.text,
                            _tradeLicenceNumber.text,
                            _bankDetail.text,
                            _panNumber.text,
                            _gst.text,
                            _vatNumber.text,
                            _registrationNumber.text,
                            _cstRegNo.text,
                            _clientReferenceNo.text,
                            _clientRefName.text,
                            _clientContactPerson.text,
                            _subCode.text,
                            _comment.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future newOrder(
    String compnayName,
    String address,
    String? address2,
    String? dpCode,
    String? concernPersonName,
    String? phoneNo,
    String? mobileNo,
    String? alternateNo,
    String? faxNo,
    String? emailId,
    String? website,
    String? tradeName,
    String? tradeLicNo,
    String? bankDetail,
    String? pan,
    String? gstNo,
    String? vatNo,
    String? regNo,
    String? cstNo,
    String? clntRefNo,
    String? clntRefName,
    String? clinetContactPerson,
    String? subCode,
    String? comment,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var loginData = preferences.getString("token") ?? "";
    Map<String, dynamic> decodeSvData = json.decode(loginData);

    String accessKey = '${decodeSvData["id"]}';
    var headers = {
      'accesskey2': accessKey,
      'mykey': loginData,
    };
    var request = http.MultipartRequest('POST', Uri.parse(Config.newOrder));
    request.fields.addAll({
      'csrf': 'S2XqttT7mvCfs24fIgI8Un5AJwjaHypNTKaEKyi3',
      'request_mode': 'offline',
      'type': "marketing",
      'Order_Date': orderDate,
      'Delivery_Date': fetchdeliverydate,
      'pan': pan ?? "",
      'vat': vatNo ?? "",
      'cst': cstNo ?? "",
      'fax': faxNo ?? "",
      'gst': cstNo ?? "",
      'reg_number': regNo ?? "",
      'email': emailId ?? "",
      'agent': selectAgentName.toString(),
      'customerid': selectCustomer.toString(),
      'branchid': selectBranch.toString(),
      'countryid': selectCountry.toString(),
      'Company_Name': compnayName,
      'address': address,
      'address2': address2 ?? "",
      'contact': 'contact',
      'phone': phoneNo ?? "",
      'comment': comment ?? "",
      'subcode': subCode ?? "",
      'mobile': mobileNo ?? "",
      'delivery_type': deliveryType.toString(),
      'reporting_typeid': '3',
      'concernPerson': concernPersonName ?? "",
      'client_reference_name': clntRefName ?? "",
      'client_contact_person': clinetContactPerson ?? "",
      'client_reference_no': clntRefNo ?? "", //'334',
      'reference': 'MNSRD07220027022',
      'website': website ?? "",
      'trade': tradeName ?? "",
      'trade_licence_number': tradeLicNo ?? "",
      'Alternate_number': alternateNo ?? "",
      'bank_details': bankDetail ?? "",
      'billto': party.toString(),
      'source_disclose': soucrce ?? "0",
      'partyname_value': partyNameId.toString(),
      'request_type': selectReportType.toString(),
      'dp_code': dpCode ?? "",
      'qc': selectQc.toString(),
      'discount_allow': discounttype,
      'branch_spoc_data': jsonstringfy
    });

    print(request.fields.toString());

    if (file != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'files0', File(file?.path ?? "").readAsBytesSync(),
          filename: file.path ?? ""));
    }
    if (file1 != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'files1', File(file1.path ?? "").readAsBytesSync(),
          filename: file1.path ?? ""));
    }

    if (file2 != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'files2', File(file2.path ?? "").readAsBytesSync(),
          filename: file2?.path ?? ""));
    }
    if (file3 != null) {
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
          'files3', File(file3.path ?? "").readAsBytesSync(),
          filename: file3.path ?? ""));
    }
    if (file4 != null) {
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
          'files4', File(file4.path ?? "").readAsBytesSync(),
          filename: file4.path ?? ""));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var updateResponse = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(updateResponse["data"].toString()),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FooterPage()));
                  },
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                updateResponse["notice"].toString(),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return null;
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

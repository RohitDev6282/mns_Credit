import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/followup_modal.dart';
import 'package:mns_management/respository/follow_up.dart';
import 'package:mns_management/utility/follow_page.dart';
import 'package:mns_management/utility/string.dart';
import 'package:mns_management/view/follow_up/followup_fom.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class FollowUpPage extends StatefulWidget {
  const FollowUpPage({Key? key}) : super(key: key);

  @override
  State<FollowUpPage> createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUpPage> {
  Map<String, dynamic>? slug;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  DateTime startdate = DateTime.now();
  DateTime endDate = DateTime.now();

  String dropdownvalue = 'All';

  // List of items in our dropdown menu
  var items = [
    'All',
    'Complete',
    'Hold',
    'Pending',
    'Cancel',
    'Working',
    'Verifying',
    'Under Qc'
  ];
  bool isBranch = false;
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List agent = [];
  List<dynamic> countryList = [];
  List state = [];
  List<dynamic> fetchCutomer = [];
  List<dynamic> fetchAgent = [];
  List<FollowupModel> getFollowData = [];
  List<dynamic> fetchCustomer = [];
  List<dynamic> fetchBranch = [];
  String? selectCustomer;
  String? selectBranch;
  bool isLoading = false;
  var followDataSource;
  bool sfdataGridView = false;
  bool waiting = true;

  String finalId = "";

  final formKey = GlobalKey<FormState>();

  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();

  getFollowUpDataList(String slug) async {
    getFollowData = await getFollowList(slug);
    followDataSource = FollowUpDataSource(orderData: getFollowData);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCustomer();
  }

  Future _getCustomer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    var headers = {'mykey': myKey};
    var response =
        await http.get(Uri.parse(Config.customerList), headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      var list = jsonDecode(data["data"]);
      if (mounted) {
        setState(() {
          fetchCustomer = list;
        });
      }
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
    Map<String, dynamic> decodeSvData = json.decode(myKey);

    String accessKey = '${decodeSvData["id"]}';
    String url = Config.branchList;
    final queryParams = '"customer_id": $selectCustomer';
    // var querryString = Uri(queryParameters: queryParams).query;
    var slug = '"status":1,"login_id":$accessKey';
    var request = url + "{$queryParams,$slug}";

    var headers = {'mykey': myKey};
    var response = await http.get(Uri.parse(request), headers: headers);
    print(jsonDecode(response.body));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      var list = jsonDecode(data["data"]);
      list.forEach((element) {
        // print(element["branch_name"]);
      });
      setState(() {
        fetchBranch = list;
      });

      return "sucess";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                Form(
                  key: formKey,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: kLightGreyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: DropdownSearch<dynamic>(
                              validator: (value) {
                                if (value == null) return 'select the Customer';

                                return null;
                              },

                              //  (value) =>
                              //     value == null ? 'Select the branch' : null,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.67,
                              autoValidateMode: AutovalidateMode.always,
                              mode: Mode.MENU,

                              // selectedItem: fetchCustomer.,
                              // selectedItem: selectCustomer,

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
                                      .singleWhere((e) =>
                                          e['customer_name'] == newValue)['id']
                                      .toString();

                                  getBranch();
                                  isBranch = true;
                                });
                              },
                              showSearchBox: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: kLightGreyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: DropdownSearch<dynamic>(
                              validator: (value) =>
                                  value == null ? 'Select the branch' : null,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.6,
                              autoValidateMode: AutovalidateMode.always,
                              mode: Mode.MENU,
                              items: fetchBranch
                                  .map(
                                    (e) => e["branch_name"],
                                  )
                                  .toList(),
                              dropdownSearchDecoration: InputDecoration(
                                  icon: isBranch
                                      ? fetchBranch.isEmpty
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
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
                                      .singleWhere((e) =>
                                          e['branch_name'] == newValue)['id']
                                      .toString();

                                  getBranch();
                                  isBranch = true;
                                });
                              },
                              showSearchBox: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 50,
                                width:
                                    MediaQuery.of(context).size.width * 0.475,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(color: kLightGreyColor)
                                  ],
                                ),
                                child: TextFormField(
                                  controller: startDateCtl,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.date_range),
                                      onPressed: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());

                                        startdate = (await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100)))!;
                                        startDateCtl.text =
                                            dateFormat.format(startdate);
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        26, 18, 4, 18),
                                    hintText: "Start Date",
                                    hintStyle: kMediumTextStyle,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: kWhiteColor, width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: kWhiteColor, width: 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: kLightGreyColor)
                                  ],
                                ),
                                child: TextFormField(
                                  controller: endDateCtl,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.date_range),
                                      onPressed: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());

                                        endDate = (await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100)))!;
                                        endDateCtl.text =
                                            dateFormat.format(endDate);
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        26, 18, 4, 18),
                                    hintText: "End Date",
                                    hintStyle: kMediumTextStyle,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: kWhiteColor, width: 0.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: kWhiteColor, width: 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: "Submit",
                                colors: kSecondaryColor,
                                onTap: () {
                                  setState(() {
                                    sfdataGridView = true;
                                  });

                                  if (selectCustomer == null &&
                                      selectBranch == null) {
                                    slug = {
                                      "start_date":
                                          dateFormat.format(startdate),
                                      "end_date": dateFormat.format(endDate),
                                      "status": 1,
                                    };
                                  } else if (selectBranch == null) {
                                    slug = {
                                      "customer_id": selectCustomer.toString(),
                                      "start_date":
                                          dateFormat.format(startdate),
                                      "end_date": dateFormat.format(endDate),
                                      "status": 1,
                                    };
                                  } else {
                                    slug = {
                                      "customer_id": selectCustomer.toString(),
                                      "branch_id": selectBranch.toString(),
                                      "start_date":
                                          dateFormat.format(startdate),
                                      "end_date": dateFormat.format(endDate),
                                      "status": 1,
                                    };
                                  }
                                  getFollowUpDataList(
                                      Uri.encodeFull(jsonEncode(slug)));
                                }),
                          ],
                        ),
                        sfdataGridView == true
                            ? followDataSource != null
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.83,
                                    child: SfDataGrid(
                                      columnWidthMode: ColumnWidthMode.none,
                                      allowSorting: true,
                                      allowMultiColumnSorting: true,
                                      source: followDataSource,
                                      columns: buildGridColumn(),
                                    ),
                                  )
                                : const CircularProgressIndicator()
                            : const Center(
                                child: Text(
                                  selectfield,
                                  style: kMediumTextStyle,
                                ),
                              ),
                        getFollowData.length >= 100
                            ? SizedBox(
                                height: 60,
                                child: SfDataPager(
                                  delegate: followDataSource,
                                  pageCount: getFollowData.length / 100,
                                  direction: Axis.horizontal,
                                ))
                            : Container()
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: kSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: const [
                    Text(
                      "Add Follow",
                      style: kWhiteMdmTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.add,
                      size: 15,
                    )
                  ],
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (selectCustomer != null && selectBranch != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowUpForm(
                                  customerId: selectCustomer.toString(),
                                  branchId: selectBranch.toString(),
                                )));
                  }
                }
              },
            )));
  }

  List<GridColumn> buildGridColumn() => <GridColumn>[
        GridColumn(
            columnName: FollowUpColumn.branchName.toString(),
            label: buildLabel('FollowUp')),
        GridColumn(
            columnName: FollowUpColumn.customerName.toString(),
            label: buildLabel('Contact Person')),
        GridColumn(
            columnName: FollowUpColumn.ifscCode.toString(),
            label: buildLabel('Description')),
        GridColumn(
            columnName: FollowUpColumn.gst.toString(),
            label: buildLabel('Mobile No.')),
      ];
  Widget buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Container(alignment: Alignment.center, child: Text(text)),
      );
}



// ${index + 1}
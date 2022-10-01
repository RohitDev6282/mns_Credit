import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/marketing_modal.dart';
import 'package:mns_management/respository/market_order.dart';
import 'package:mns_management/utility/home_page.dart';
import 'package:mns_management/view/new_order.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/drawer.dart';
import 'package:mns_management/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../utility/string.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List fetchCustomer = [];
  List<dynamic> fetchBranch = [];
  List<MarketingOrderModel> getORderListData = [];
  List<MarketingOrderModel> fetchMarketingOrder = [];

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String? selectCustomer;
  String? selectBranch;
  bool isLoading = false;
  bool isBranch = false;

  bool sfdataGridView = false;
  bool pagination = false;
  var orderDataSource;

  @override
  void initState() {
    super.initState();
    _getCustomer();
  }

  Map<String, String>? slug;

  getData(String slug) async {
    getORderListData = await getMarketingOrder(slug);
    orderDataSource = MarketOrderListDataSource(orderData: getORderListData);
    setState(() {});
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
    // var querryString = Uri(queryParameters: queryParams).query;
    Map<String, dynamic> decodeSvData = json.decode(myKey);

    String accessKey = '${decodeSvData["id"]}';
    var slug = '"status":1,"login_id":$accessKey';
    var request = url + "{$queryParams,$slug}";

    var headers = {'mykey': myKey};
    var response = await http.get(Uri.parse(request), headers: headers);
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

  final String dropDownValue = "Select the report";

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
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());

  List agent = [];
  List<dynamic> countryList = [];
  List state = [];
  List<dynamic> fetchCutomer = [];
  List<dynamic> fetchAgent = [];

  bool waiting = true;

  String finalId = "";

  final formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;
  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();

  bool sort = true; // or `false`...

  var selectedItem = -1;

  int itemCount = 100;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(elevation: 8, child: AppDrawer()),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: kLightGreyColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: DropdownSearch<dynamic>(
                            validator: (value) =>
                                value == null ? 'Select the customer' : null,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.67,
                            autoValidateMode: AutovalidateMode.always,
                            mode: Mode.MENU,
                            items: fetchCustomer
                                .map((e) => e["customer_name"])
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: const BoxDecoration(
                      //       color: kLightGreyColor,
                      //       borderRadius: BorderRadius.all(Radius.circular(12)),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 10.0),
                      //       child: DropdownButton(
                      //         hint: Row(
                      //           children: [
                      //             const Text(
                      //               "Select the Customer",
                      //               style: kMediumTextStyle,
                      //             ),
                      //             const Spacer(),
                      //             fetchCustomer.isEmpty
                      //                 ? const Loader(
                      //                     height: 20,
                      //                     width: 20,
                      //                   )
                      //                 : Container()
                      //           ],
                      //         ),
                      //         underline:
                      //             DropdownButtonHideUnderline(child: Container()),
                      //         value: selectCustomer,
                      //         onChanged: (String? newValue) {
                      //           setState(() {
                      //             getBranch();
                      //             isBranch = true;
                      //             selectCustomer = newValue!;
                      //           });
                      //         },
                      //         isExpanded: true,
                      //         items: fetchCustomer.map((val) {
                      //           return DropdownMenuItem<String>(
                      //             value: val["id"].toString(),
                      //             child: Text(
                      //               val["customer_name"].length > 20
                      //                   ? val["customer_name"].substring(0, 20) +
                      //                       '...'
                      //                   : val["customer_name"],
                      //               style: kBMTextStyle,
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: kLightGreyColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: DropdownSearch<dynamic>(
                            validator: (value) =>
                                value == null ? 'Select the branch' : null,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.67,
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: const BoxDecoration(
                      //       color: kLightGreyColor,
                      //       borderRadius: BorderRadius.all(Radius.circular(12)),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 10.0),
                      //       child: DropdownButton(
                      //         hint: Row(
                      //           children: [
                      //             const Text(
                      //               "Select the Branch",
                      //               style: kMediumTextStyle,
                      //             ),
                      //             const Spacer(),
                      //             isBranch
                      //                 ? fetchBranch.isEmpty
                      //                     ? Loader(
                      //                         height: 20,
                      //                         width: 20,
                      //                       )
                      //                     : Container()
                      //                 : Container()
                      //           ],
                      //         ),
                      //         isExpanded: true,
                      //         value: selectBranch,
                      //         underline: DropdownButtonHideUnderline(
                      //             child: Container()),
                      //         items: fetchBranch.map((val) {
                      //           return DropdownMenuItem<String>(
                      //             child: Text(
                      //               val['branch_name'],
                      //               style: kMediumTextStyle,
                      //             ),
                      //             value: val['id'].toString(),
                      //           );
                      //         }).toList(),
                      //         onChanged: (String? value) {
                      //           setState(() {
                      //             selectBranch = value!;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .475,
                              decoration: const BoxDecoration(
                                color: kLightGreyColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButton(
                                  hint: Text(
                                    dropdownvalue,
                                    style: kMediumTextStyle,
                                  ),
                                  underline: DropdownButtonHideUnderline(
                                      child: Container()),
                                  isExpanded: true,
                                  style: kMediumTextStyle,
                                  items: items.map(
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
                                        dropdownvalue = val!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.475,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(color: kLightGreyColor)
                                ],
                              ),
                              child: TextFormField(
                                readOnly: true,
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(26, 18, 4, 18),
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
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.475,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(color: kLightGreyColor)
                                ],
                              ),
                              child: TextFormField(
                                readOnly: true,
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(26, 18, 4, 18),
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
                          CustomButton(
                            text: "Submit",
                            colors: kSecondaryColor,
                            onTap: () {
                              if (selectCustomer != null &&
                                  selectBranch != null) {
                                setState(() {
                                  sfdataGridView = true;
                                });

                                slug = {
                                  "customer_id": selectCustomer.toString(),
                                  "branch_id": selectBranch.toString(),
                                  "order_status": dropdownvalue,
                                  "start_date": dateFormat.format(startdate),
                                  "end_date": dateFormat.format(endDate)
                                };
                                getData(Uri.encodeFull(jsonEncode(slug)));
                              }
                            },
                          )
                        ],
                      ),
                      sfdataGridView == true
                          ? orderDataSource != null
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.83,
                                    child: SfDataGrid(
                                      frozenColumnsCount: 0,
                                      allowSorting: true,
                                      source: orderDataSource,
                                      columns: buildGridColumn(),
                                    ),
                                  ),
                                )
                              : const CircularProgressIndicator()
                          : const Center(
                              child: Text(
                                selectfield,
                                style: kMediumTextStyle,
                              ),
                            ),
                      getORderListData.length >= 100
                          ? SizedBox(
                              child: SfDataPager(
                              delegate: orderDataSource,
                              pageCount: getORderListData.length / 100,
                              direction: Axis.horizontal,
                            ))
                          : Container()
                    ],
                  ),
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
                  "Add Order",
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewOrder()));
          },
        ),
      ),
    );
  }

  Widget _style(BuildContext context, String? selectedItem) {
    return Text(
      selectedItem!,
      style: const TextStyle(fontFamily: 'MeQuran2'),
    );
  }

  List<GridColumn> buildGridColumn() => <GridColumn>[
        GridColumn(
            minimumWidth: 140,
            columnName: HomeColumn.orderId.toString(),
            label: buildLabel('Order Id.')),
        GridColumn(
            minimumWidth: 140,
            columnName: HomeColumn.compnayName.toString(),
            label: buildLabel('Company Name')),
        GridColumn(
            minimumWidth: 140,
            columnName: HomeColumn.customerName.toString(),
            label: buildLabel('Customer Name')),
        GridColumn(
            minimumWidth: 140,
            columnName: HomeColumn.branchName.toString(),
            label: buildLabel('Branch Name')),
        GridColumn(
            minimumWidth: 140,
            columnName: HomeColumn.reportType.toString(),
            label: buildLabel('Report Type')),
      ];
  Widget buildLabel(String text) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
            )),
      );

// drawer side bar
  Widget getDrawerItem(String name, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = pos;
        });
      },
      child: Container(
        color: selectedItem == pos ? kSelectedrawerColor : kWhiteColor,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: selectedItem == pos ? kSecondaryColor : kBlackColor,
                    fontSize: 18))
          ],
        ),
      ),
    );
  }
}

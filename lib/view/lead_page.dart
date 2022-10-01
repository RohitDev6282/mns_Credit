import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/leaddata_model.dart';
import 'package:mns_management/respository/lead_service.dart';
import 'package:mns_management/utility/lead_data.dart';
import 'package:mns_management/utility/string.dart';
import 'package:mns_management/view/follow_up/leadfollow.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LeadPage extends StatefulWidget {
  const LeadPage({Key? key}) : super(key: key);

  @override
  State<LeadPage> createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  Map<String, dynamic>? slug;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  DateTime startdate = DateTime.now();
  DateTime endDate = DateTime.now();
  String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  List agent = [];
  List<dynamic> countryList = [];
  List state = [];
  List<dynamic> fetchCutomer = [];
  List<dynamic> fetchAgent = [];
  List<LeadListModel> getFollowData = [];
  List<dynamic> fetchCustomer = [];
  List<dynamic> fetchBranch = [];
  String? selectCustomer;
  String? selectBranch;
  bool isLoading = false;

  bool sfdataGridView = false;
  bool waiting = true;
  final formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;

  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();
  var followLeadSource;
  getLeadDataList(String slug) async {
    var getLeadData = await getLeadList(slug);
    followLeadSource = LeadDataSource(leadData: getLeadData);
    setState(() {});
  }

  Future _getCustomer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    var headers = {'mykey': myKey};
    var response =
        await http.get(Uri.parse(Config.customerList), headers: headers);
    if (response.statusCode == 200) {
      isLoading = true;

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

  @override
  void initState() {
    super.initState();
    _getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Expanded(
              child: SingleChildScrollView(
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
                          validator: (value) {
                            if (value == null) return 'select the Customer';

                            return null;
                          },
                          maxHeight: MediaQuery.of(context).size.height * 0.67,
                          autoValidateMode: AutovalidateMode.always,
                          mode: Mode.MENU,
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
                              contentPadding: EdgeInsets.all(12)),
                          onChanged: (newValue) {
                            setState(() {
                              selectCustomer = fetchCustomer
                                  .singleWhere((e) =>
                                      e['customer_name'] == newValue)['id']
                                  .toString();
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
                            width: MediaQuery.of(context).size.width * 0.475,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
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
                            if (formKey.currentState!.validate()) {
                              if (selectCustomer == null) {
                                slug = {
                                  "start_date": dateFormat.format(startdate),
                                  "end_date": dateFormat.format(endDate),
                                  "status": 3,
                                };
                              }
                            } else {
                              slug = {
                                "customer_id": selectCustomer.toString(),
                                "branch_id": 0,
                                "start_date": dateFormat.format(startdate),
                                "end_date": dateFormat.format(endDate),
                                "status": 3,
                              };
                            }
                            getLeadDataList(Uri.encodeFull(jsonEncode(slug)));
                          },
                        ),
                      ],
                    ),
                    sfdataGridView == true
                        ? followLeadSource != null
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.83,
                                child: SfDataGrid(
                                    allowSorting: true,
                                    allowMultiColumnSorting: true,
                                    source: followLeadSource,
                                    columnWidthMode: ColumnWidthMode.none,
                                    columns: buildGridColumn()),
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
                              delegate: followLeadSource,
                              pageCount: getFollowData.length / 100,
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
                "Add Lead",
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
          // print(row.getCells()[1].value.toString() +
          // " " +
          // row.getCells()[0].value.toString());
          if (formKey.currentState!.validate()) {
            if (selectCustomer != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LeadFollowUp(
                            customerId: selectCustomer.toString(),
                            branchId: selectBranch.toString(),
                          )));
            }
          }
        },
      ),
    );
  }

  List<GridColumn> buildGridColumn() => <GridColumn>[
        GridColumn(
            columnName: LeadColumn.id.toString(), label: buildLabel('ID')),
        GridColumn(
            columnName: LeadColumn.customer.toString(),
            label: buildLabel('customer')),
        GridColumn(
            columnName: LeadColumn.branchName.toString(),
            label: buildLabel('BrachName')),
        GridColumn(
            columnName: LeadColumn.clientRefName.toString(),
            label: buildLabel('CLientRefName'))
      ];
  Widget buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(alignment: Alignment.center, child: Text(text)),
      );
}

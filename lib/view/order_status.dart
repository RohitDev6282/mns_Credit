import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/orderlist_modal.dart';
import 'package:mns_management/utility/string.dart';
import 'package:mns_management/view/new_order.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/textfiled.dart';

import 'package:http/http.dart' as http;
import 'package:mns_management/constant/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  Map<String, dynamic>? slug;
  final TextEditingController mnsrController = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Order No';
  bool sfdataGridView = false;

  // List of items in our dropdown menu
  var items = [
    'Order No',
    // 'Company Name',
    // 'Client Ref',
    // 'Client Ref Name',submit
  ];

  // var dataResource;
  List<SearchApiModel>? getSearchData;

  var listcheck;
  var message;
  searchData(String slug) async {
    getSearchData = await getPendingList(slug);

    sfdataGridView = true;
    // dataResource = OrderStatusDataSource(orderStatusData: getSearchData);
    setState(() {});
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 12, right: 12),
                          child: Container(
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
                          padding: const EdgeInsets.only(
                              left: 12.0, top: 0, right: 12),
                          child: TextFieldWidget(
                              validiate: (val) {
                                if (val.isEmpty) {
                                  return "Required Mnsrs No.";
                                }
                                if (val.length != 15) {
                                  return "Mnsr No must be 15 digit  long";
                                }
                              },
                              keyType: TextInputType.name,
                              hinttest: "MNSR NO.",
                              label: const Text(""),
                              controller: mnsrController),
                        ),
                        CustomButton(
                          text: "Submit",
                          colors: kSecondaryColor,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              slug = {
                                "receiptnumber":
                                    mnsrController.text.toUpperCase(),
                              };

                              getPendingList(Uri.encodeFull(jsonEncode(slug)));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  sfdataGridView == true
                      ? getSearchData != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: getSearchData?.length,
                              itemBuilder: (context, index) {
                                if (message != null) {
                                  return const Center(
                                    child: Text('No Data Found'),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: kBlackColor),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 5),
                                              child: Datawidget(
                                                text1: getSearchData?[index]
                                                        .getcustomer
                                                        ?.customerName
                                                        .toString() ??
                                                    "no Customer Name",
                                                text2: getSearchData?[index]
                                                        .receiptnumber
                                                        .toString() ??
                                                    "No receipt Number",
                                                text3: getSearchData?[index]
                                                        .orderStatus
                                                        .toString() ??
                                                    "no order status",
                                                text4: getSearchData?[index]
                                                        .companyName
                                                        .toString() ??
                                                    "company Name Found",
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: Datawidget(
                                                text1: getSearchData?[index]
                                                        .getBranch
                                                        ?.branchName
                                                        .toString() ??
                                                    "No branch",
                                                text2: getSearchData?[index]
                                                        .createdDate
                                                        .toString() ??
                                                    "",
                                                text3: getSearchData?[index]
                                                        .getrequest
                                                        ?.reportDeliveryDate
                                                        .toString() ??
                                                    "no Delivery Data",
                                                text4: getSearchData?[index]
                                                        .getrequest
                                                        ?.clientRef
                                                        .toString() ??
                                                    "No data found",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : const CircularProgressIndicator()
                      : const Center(
                          child: Text(
                            selectfield,
                            style: kMediumTextStyle,
                          ),
                        ),
                ],
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
    ));
  }

  Future getPendingList(String slug) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var loginData = preferences.getString("token") ?? "";
    Map<String, dynamic> decodeSvData = json.decode(loginData);

    String accessKey = '${decodeSvData["id"]}';
    var headers = {
      'accesskey2': accessKey,
      'mykey': loginData,
    };

    var baseSlug = base64.encode(utf8.encode(slug));
    String url = Config.searchApi +
        baseSlug +
        "?relation=[%22Getcustomer%22,%22GetBranch%22,%22GetreportName%22,%22Getrequest%22,%22Getpartyname%22,%22Getcountry%22,%22Getinvoice%22]";

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 180) {
      var fetchdata = jsonDecode(response.body);
      if (fetchdata["length"] != 0) {
        var orderListData = fetchdata["data"];
        setState(() {
          sfdataGridView = true;
          getSearchData = searchApiModelFromJson(orderListData);
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("No Result Found"),
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
    } else if (response.statusCode == 400) {
      final searchApiModel = jsonDecode(response.body);
    }
  }
}

class Datawidget extends StatelessWidget {
  String text1;
  String text2;
  String text3;
  String text4;
  Datawidget(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 50,
            width: 180,
            child: Text(
              text1,
              style: kMediumTextStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 50,
            width: 180,
            child: Text(
              text2,
              style: kMediumTextStyle,
              maxLines: 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
              height: 50,
              width: 180,
              child: Text(text3, maxLines: 2, style: kMediumTextStyle)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
              height: 50,
              width: 180,
              child: Text(text4, maxLines: 2, style: kMediumTextStyle)),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/view/footer.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/textfiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FollowUpForm extends StatefulWidget {
  String customerId;
  String branchId;
  FollowUpForm({
    Key? key,
    required this.customerId,
    required this.branchId,
  }) : super(key: key);

  @override
  State<FollowUpForm> createState() => _FollowUpFormState();
}

class _FollowUpFormState extends State<FollowUpForm> {
  Future getSpokePersonList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    String url = Config.branchSpoke;
    Map<String, String> queryParams = {
      "branch_id": widget.branchId.toString(),
      "status": "1"
      // selectBranch.toString()
    };
    String jsonString = json.encode(queryParams);
    String request = Uri.encodeFull(jsonString);
    var header = {
      'mykey': myKey,
    };
    var response = await http.get(Uri.parse(url + request), headers: header);
    var data = json.decode(response.body);
    // var list = jsonDecode(data["data"]);

    setState(() {
      fetchspokPrsn = jsonDecode(data["data"]);
      fetchspokPrsn.add({"spoc_name": "other", "id": "other"});
    });

    return "sucess";
  }

  String? selectSpokePeson;
  String? type;
  bool visibilty1 = false;
  bool visibilty2 = false;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime startdate = DateTime.now();
  DateTime endDate = DateTime.now();
  String followupVie = "--Please select follow Up vie--";
  String contactPerson = "--Please select Spoke person--";
  var file;
  List<dynamic> fetchspokPrsn = [];
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    setState(() {
      file = File(image?.path ?? "No image selected");
    });
    return file;

//print(‘Image picked’);
  }

  late ScaffoldMessengerState scaffoldMessenger;
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();
  final TextEditingController _cordinatorName = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  void initState() {
    super.initState();
    getSpokePersonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kSecondaryColor, title: const Text("Add Follow up")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Type",
                  style: kBLTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => kSecondaryColor),
                              value: 'activity',
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  visibilty1 = true;
                                  type = "activity";
                                  visibilty2 = false;
                                });
                              }),
                          const Expanded(
                            child: Text('Activity'),
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
                              value: 'planner',
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  visibilty1 = true;
                                  type = "planner";
                                  visibilty2 = false;
                                });
                              }),
                          const Expanded(
                            child: Text('Planner'),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("FollowUp Date"),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(color: kLightGreyColor)
                              ],
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please select the Start date";
                                }
                              },
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
                                            lastDate: DateTime(2100))) ??
                                        DateTime.now();
                                    startDateCtl.text =
                                        dateFormat.format(startdate);
                                  },
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(26, 18, 4, 18),
                                hintText: DateTime.now().toString(),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Next FollowUp Date"),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: kLightGreyColor)
                              ],
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (type == "planner") {
                                  if (value!.isEmpty) {
                                    return "Please select end data";
                                  }
                                }
                                return null;
                              },
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
                                            lastDate: DateTime(2100))) ??
                                        DateTime.now();
                                    endDateCtl.text =
                                        dateFormat.format(endDate);
                                  },
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(26, 18, 4, 18),
                                hintText: DateTime.now().toString(),
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
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: kLightGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none),
                      hint: Text(
                        followupVie,
                        style: kMediumTextStyle,
                      ),
                      validator: (value) => value == null
                          ? 'please selec the follow up kia'
                          : null,
                      isExpanded: true,
                      style: kMediumTextStyle,
                      items: [
                        'By Call',
                        'By Sms',
                        'By Email',
                        'By Whatsup',
                        'By Visit',
                      ].map(
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
                            followupVie = val!;
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        "-- Please Select Spoke Person --",
                        style: kMediumTextStyle,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the spoke Person';
                        }

                        return null;
                      },
                      isExpanded: true,
                      items: fetchspokPrsn.map((val) {
                        return DropdownMenuItem(
                            child: Text(
                              val['spoc_name'],
                              style: kMediumTextStyle,
                            ),
                            value: val['id'].toString());
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectSpokePeson = value.toString();
                        });
                      },
                      value: selectSpokePeson,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.text,
                    hinttest: "Enter Cordinator Name",
                    label: const Text("Name of Cordinator"),
                    validiate: (value) {
                      if (selectSpokePeson == "other") {
                        if (value!.isEmpty) {
                          return "Please fill the Co-ordinate Name";
                        }
                      }
                      return null;
                    },
                    controller: _cordinatorName),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.emailAddress,
                    hinttest: "Enter the Email",
                    label: const Text("Email"),
                    controller: _emailCtl),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.number,
                    hinttest: "Enter the phone Number",
                    label: const Text("Phone"),
                    controller: _phoneCtl),
                const SizedBox(height: 8),
                TextFieldWidget(
                    keyType: TextInputType.text,
                    hinttest: "",
                    label: const Text("Descriptioin"),
                    validiate: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill the Desrciption';
                      }
                    },
                    controller: _description),
                Row(
                  children: [
                    CustomButton(
                      text: "upload Image",
                      colors: kPrimaryColor,
                      onTap: () {
                        getImage();
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
                const SizedBox(height: 8),
                Center(
                    child: CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            followupAdd(_cordinatorName.text, _emailCtl.text,
                                _phoneCtl.text, _description.text);
                          }
                        },
                        text: "Add FollowUp",
                        colors: kDarkGreyColor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future followupAdd(
    String cordinatorName,
    String email,
    String phone,
    String description,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var loginData = preferences.getString("token") ?? "";
    Map<String, dynamic> decodeSvData = json.decode(loginData);
    // print(decodeSvData);
    String accessKey = '${decodeSvData["id"]}';
    var headers = {
      'accesskey2': accessKey,
      'mykey': loginData,
    };

    var request = http.MultipartRequest('POST', Uri.parse(Config.followAdd));

    request.fields.addAll({
      "customer_id": widget.customerId,
      "type": type.toString(),
      "branch_id": widget.branchId,
      "spoc": selectSpokePeson.toString(),
      "followup_date": dateFormat.format(startdate).toString(),
      "next_followup_date": dateFormat.format(endDate).toString(),
      "followupby": followupVie,
      "email": email,
      "name_of_cordinator": cordinatorName,
      "phone": phone,
      "description": description,
    });

    if (file != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'file', File(file?.path ?? null).readAsBytesSync(),
          filename: file?.path ?? ""));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var updateResponse = jsonDecode(await response.stream.bytesToString());

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(updateResponse["data"].toString()),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FooterPage(currentTab: 2)));
                  },
                ),
              ],
            );
          });
    } else {
      return null;
    }
  }
}

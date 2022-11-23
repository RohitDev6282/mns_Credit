import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:mns_management/constant/api_config.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/view/footer.dart';
import 'dart:convert';
import 'package:mns_management/widget/custom_button.dart';
import 'package:mns_management/widget/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with CodeAutoFill {
  final String comingSms = 'Unknown';

  String signature = "app signature";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code;
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
    // cancel();
  }

  @override
  void initState() {
    super.initState();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  bool isLoggedId = false;
  Future otpSend() async {
    Map data = {
      'username': usrNameCntrl.text,
      'password': passwerdCntrl.text,
    };

    var response = await http.post(Uri.parse(Config.loginUrl), body: data);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var loginResponse = json.decode(response.body);
      if (loginResponse["data"]) {
        var localUser = loginResponse['prop'];

        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: Loader(
                  height: 50,
                  width: 50,
                )),
            barrierDismissible: false);

        // a fake login call using Future.delayed

        await Future.delayed(const Duration(seconds: 1), () => true)
            .timeout(const Duration(seconds: 3), onTimeout: () => false);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FooterPage()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", localUser);
      }
    } else {
      var loginResponse = json.decode(response.body);
      String msg = loginResponse['msg'];
      final snackBar = SnackBar(
        content: Text(msg.toString(), style: kWhiteLrgTextStyle),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final scaffold = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalfromKey = GlobalKey<FormState>();
  final TextEditingController usrNameCntrl = TextEditingController();
  final TextEditingController passwerdCntrl = TextEditingController();
  late String value;
  // late LoginRequestModel requestModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/mns.jpg",
                  width: width / 1.2, height: width / 2.5),
              Container(
                margin: const EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: kWhiteColor, showShadow: true, radius: 4),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      controller: usrNameCntrl,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: kTextSizeLargeMedium,
                      ),
                      decoration: InputDecoration(
                        label: const Text("User Name"),
                        labelStyle: MaterialStateTextStyle.resolveWith(
                            (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? kSecondaryColor
                                  : kSecondaryColor;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        hintText: "Enter the UserName",
                        hintStyle: const TextStyle(color: kGreyColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: kGreyColor, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: kGreyColor, width: 0.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwerdCntrl,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: kTextSizeLargeMedium,
                      ),
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        labelStyle: MaterialStateTextStyle.resolveWith(
                            (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? kSecondaryColor
                                  : kSecondaryColor;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        hintText: "Enter the Password",
                        hintStyle: const TextStyle(color: kGreyColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: kGreyColor, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: kGreyColor, width: 0.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: CustomButton(
                          onTap: () {
                            otpSend();

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => OtpScreen()));
                            // toasty(context, "Sign in clicked");
                          },
                          colors: kPrimaryColor,
                          text: 'Sign IN',
                        )),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                    //   child: Text(
                    //     "This is the current app signature: $appSignature",
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color? bgColor,
      var showShadow = false}) {
    return BoxDecoration(
      color: kWhiteColor,
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}

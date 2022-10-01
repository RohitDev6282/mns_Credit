import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/view/footer.dart';
import 'package:mns_management/widget/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String? otpcheck;
  OtpScreen({Key? key, this.otpcheck}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  TextEditingController textEditingController1 = TextEditingController();
  String codeValue = "";
  @override
  void codeUpdated() {
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalformKey = GlobalKey<FormState>();
  final TextEditingController otp = TextEditingController();
  @override
  void initState() {
    super.initState();
    listenOtp();
  }

  void listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Container(
            height: 300,
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(color: kLightGreyColor),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: Text(
                          "Otp has been sent to your Mobile Number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PinFieldAutoFill(
                        currentCode: codeValue,
                        codeLength: 6,
                        onCodeChanged: (code) {
                          setState(() {
                            codeValue = code.toString();
                          });
                        },
                        onCodeSubmitted: (val) {
                          // print("onCodeSubmitted $val");
                        },
                        decoration: UnderlineDecoration(
                          bgColorBuilder:
                              FixedColorBuilder(Colors.grey.shade300),
                          textStyle: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          colorBuilder: FixedColorBuilder(Colors.grey.shade300),
                        ),
                      ),
                      const SizedBox(
                        height: height,
                      ),
                      const Text(
                        "Enter OTP Here",
                        style: TextStyle(color: kDarkGreyColor),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Didn't Receive OTP",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FooterPage()));
                          },
                          text: 'Verify Otp here',
                          colors: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      )),
    );
  }

  bool validateAndSave() {
    final form = globalformKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

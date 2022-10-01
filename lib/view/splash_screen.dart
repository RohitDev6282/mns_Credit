import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mns_management/view/auth/login.dart';
import 'package:mns_management/view/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getuserValidation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var _finalStatus = preferences.getString("token");
    if (_finalStatus != null) {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FooterPage()),
              ));
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false));
    }
  }

  @override
  void initState() {
    super.initState();
    getuserValidation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(0),
      child: Scaffold(
        body: Center(
          child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/mns.jpg'),
                    fit: BoxFit.fitWidth),
              )),
        ),
      ),
    );
  }
}

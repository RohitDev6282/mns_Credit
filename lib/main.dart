import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/view/new_order.dart';
import 'package:mns_management/view/splash_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kSecondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home:
          //  const NewOrder()
          const SplashScreen(),
    );
  }
}

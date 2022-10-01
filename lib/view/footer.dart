import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/modals/route_arguement.dart';
import 'package:mns_management/view/auth/login.dart';
import 'package:mns_management/view/follow_up.dart';
import 'package:mns_management/view/home.dart';
import 'package:mns_management/view/lead_page.dart';
import 'package:mns_management/view/order_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utility/string.dart';

// ignore: must_be_immutable
class FooterPage extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = const OrderStatus();
  RouteArgument? routeArgument;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  FooterPage({
    Key? key,
    this.currentTab,
  }) : super(key: key) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  State<FooterPage> createState() => _FooterPageState();
}

class _FooterPageState extends State<FooterPage> {
  late ScaffoldMessengerState scaffoldMessenger;
  final formKey = GlobalKey<FormState>();
  final TextEditingController profileImageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedItem = -1;
  int? pos;
  bool isUsername = false;

  @override
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
    Timer(const Duration(milliseconds: 100), () {
      getData();
    });
  }

  @override
  void didUpdateWidget(FooterPage oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = const HomeWidget();
          break;

        case 1:
          widget.currentPage = const OrderStatus();
          break;
        case 2:
          widget.currentPage = const FollowUpPage();
          break;
        case 3:
          widget.currentPage = const LeadPage();
      }
    });
  }

  String? username;
  Future getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var myKey = preferences.getString("token") ?? "";
    Map<String, dynamic> decodeSvData = json.decode(myKey);

    setState(() {
      isUsername = true;
      username = '${decodeSvData["username"]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            elevation: 8,
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 12, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        decoration: const BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24.0),
                                topRight: Radius.circular(24.0))),
                        /*User Profile*/
                        child: Row(
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                'assets/images/mns.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    isUsername
                                        ? Text(
                                            username.toString().toUpperCase(),
                                            style: kWhiteLrgTextStyle,
                                          )
                                        : Container(),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    getDrawerItem(drawer1, 1, (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FooterPage(currentTab: 0)));
                    })),
                    getDrawerItem(drawer2, 2, (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FooterPage(currentTab: 1)));
                    })),
                    getDrawerItem(drawer3, 3, (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FooterPage(currentTab: 2)));
                    })),
                    getDrawerItem(drawer4, 4, (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FooterPage(currentTab: 3)));
                    })),
                    InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.remove('token');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) =>
                                    const LoginPage()));
                      },
                      child: Container(
                        color: selectedItem == pos
                            ? kSelectedrawerColor
                            : kWhiteColor,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Row(
                          children: const [
                            SizedBox(width: 20),
                            Text("SignOut",
                                style:
                                    TextStyle(color: kBlackColor, fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: kSecondaryColor,
            title: const Text(
              ("MNS Credit"),
            ),
          ),
          // key: widget.scaffoldKey,
          // drawer: DrawerWidget(),
          // endDrawer: FilterWidget(onFilter: (filter) {
          //   Navigator.of(context)
          //       .pushReplacementNamed('/Pages', arguments: widget.currentTab);
          // }),
          body: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              widget.currentPage,
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Fixed
            backgroundColor: kSecondaryColor, // <-- This works for fixed
            selectedItemColor: kWhiteColor,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: const IconThemeData(size: 28),
            currentIndex: widget.currentTab,
            onTap: (int i) {
              _selectTab(i);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_work),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                label: 'Order Status',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.follow_the_signs),
                label: 'Follow Up',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Lead',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDrawerItem(String name, int pos, GestureTapCallback? onTap) {
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
                style: TextStyle(
                    color: selectedItem == pos ? kSecondaryColor : kBlackColor,
                    fontSize: 18))
          ],
        ),
      ),
    );
  }
}

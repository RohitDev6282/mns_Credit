import 'package:flutter/material.dart';
import 'package:mns_management/constant/constant.dart';
import 'package:mns_management/utility/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int? pos;
  var selectedItem = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.jpeg"),
                          radius: 40),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Rohit Singh",
                                style: TextStyle(
                                    color: kWhiteColor, fontSize: 20)),
                            SizedBox(height: 8),
                            Text(
                              "Rohit82@gmail.com",
                              style: TextStyle(color: kWhiteColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              getDrawerItem(drawer1, 1),
              getDrawerItem(drawer2, 2),
              getDrawerItem(drawer3, 3),
              getDrawerItem(drawer4, 4),
              const SizedBox(height: 30),
              const Divider(color: kGreyColor, height: 1),
              const SizedBox(height: 30),
              getDrawerItem(drawer6, 6),
              getDrawerItem(drawer7, 7),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDrawerItem(
    String name,
    int pos,
  ) {
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

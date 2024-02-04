import 'dart:core';

import 'package:mcloud/main.dart';
import 'package:mcloud/screens/mCUpgradeAccountScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DrawerComponents extends StatefulWidget {
  static String tag = '/DrawerComponents';

  const DrawerComponents({super.key});

  @override
  DrawerComponentsState createState() => DrawerComponentsState();
}

class DrawerComponentsState extends State<DrawerComponents> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double percentage = 4.3;
    double factor = percentage / 100.0;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              margin: const EdgeInsets.all(0),
              // just a frictional character name for the user
              accountName: Text('John Dae', style: boldTextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: CSDarkBlueColor,
                child: Text("JD", style: boldTextStyle(size: 20, color: Colors.white)),
              ),
              // just a frictional character email for the user

              accountEmail: const Text('example@gmail.com'),
            ),
            Container(
              height: 5,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 0.1),
                      color: CSGreyColor,
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: factor,
                    child: Container(
                      color: CSDarkBlueColor,
                    ),
                  )
                ],
              ),
            ),
            Text(
              "$percentage% of 2.0 GB used",
              style: boldTextStyle(color: Colors.grey, size: 14),
            ).paddingOnly(left: 16, right: 16, bottom: 16),
            Container(
              height: 50,
              color: CSDarkBlueColor,
              child: Row(
                children: [
                  10.width,
                  Image.asset(CSmCloudLogo, height: 30, width: 30),
                  Text(
                    'Upgrade for more space',
                    style: boldTextStyle(color: Colors.white, size: 17),
                  ).center().expand(),
                ],
              ),
            ).paddingSymmetric(horizontal: 16).onTap(
              () {
                finish(context);
                const UpgradeAccountScreen().launch(context);
              },
            ),
            10.height,
            ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getCSDrawerList.length,
              itemBuilder: (context, index) {
                return Container(
                  color: getCSDrawerList[index].isSelected ? Colors.blueGrey.withOpacity(0.3) : transparentColor,
                  child: createBasicListTile(
                    text: getCSDrawerList[index].title!,
                    icon: getCSDrawerList[index].icon,
                    onTap: () {
                      if (currentIndex == index) {
                        finish(context);
                      } else {
                        currentIndex = index;
                        if (getCSDrawerList[index].title != "Setting" && getCSDrawerList[index].title != "Upgrade Account") {
                          for (var element in getCSDrawerList) {
                              element.isSelected = false;
                            }
                        }
                        getCSDrawerList[index].isSelected = true;
                        getCSDrawerList.elementAt(getCSDrawerList.length - 1).isSelected = false;
                        getCSDrawerList.elementAt(getCSDrawerList.length - 2).isSelected = false;

                        finish(context);

                        getCSDrawerList[index].goto.launch(context);
                      }
                    },
                  ).paddingSymmetric(horizontal: 16),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

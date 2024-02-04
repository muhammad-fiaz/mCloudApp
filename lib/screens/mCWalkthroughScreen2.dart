import 'package:mcloud/screens/mCConnectWithComputerScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkthroughScreen2 extends StatelessWidget {
  const WalkthroughScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(""),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(CSmCloudLogo, height: 200),
              Wrap(
                children: [
                  Text(
                    "Access your computer's files on this device",
                    textAlign: TextAlign.center,
                    style: boldTextStyle(size: 25),
                  ).paddingTop(20),
                  Text(
                    "Changes you make to files on your computer will also appear on this device.",
                    textAlign: TextAlign.center,
                    style: primaryTextStyle(size: 17),
                  ).paddingTop(20)
                ],
              ),
              Text(
                "Not near your computer?",
                style: primaryTextStyle(size: 18, color: Colors.grey),
              ).paddingTop(20),
              Text(
                "Email me a link",
                style: primaryTextStyle(
                  size: 18,
                  color: CSDarkBlueColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              Container(
                height: 50,
                decoration: const BoxDecoration(color: CSDarkBlueColor),
                child: Text('Setup', style: boldTextStyle(color: Colors.white, size: 17)).center(),
              ).paddingTop(30).onTap(
                () {
                  ConnectWithComputerScreen().launch(context);
                },
              ),
            ],
          ).paddingAll(20),
        ),
      ),
    );
  }
}

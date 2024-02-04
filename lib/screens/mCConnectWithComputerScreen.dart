import 'package:mcloud/screens/mCDashboardScreen.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ConnectWithComputerScreen extends StatefulWidget {
  static String tag = '/ConnectWithComputerScreen';

  const ConnectWithComputerScreen({super.key});

  @override
  ConnectWithComputerScreenState createState() => ConnectWithComputerScreenState();
}

class ConnectWithComputerScreenState extends State<ConnectWithComputerScreen> {
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
    return Scaffold(
      appBar: appBarWidget(""),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "On your computer, go to ",
                    style: primaryTextStyle(size: 24),
                    children: [
                      TextSpan(
                        text: "$AppName.com/connect",
                        style: boldTextStyle(size: 25),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(width: 250, height: 250, color: Colors.black).onTap(() {
              const DashboardScreen().launch(context);
              // finish(context);
            }).paddingTop(20),
            Wrap(
              children: [
                Text(
                  "Point your phone at your computer with the website above and wait.",
                  style: primaryTextStyle(size: 20),
                  textAlign: TextAlign.center,
                ).paddingTop(20)
              ],
            )
          ],
        ).paddingAll(20),
      ),
    );
  }
}

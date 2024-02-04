import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PasscodeScreen extends StatefulWidget {
  static String tag = '/PasscodeScreen';

  const PasscodeScreen({super.key});

  @override
  PasscodeScreenState createState() => PasscodeScreenState();
}

class PasscodeScreenState extends State<PasscodeScreen> {
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
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => finish(context),
              ),
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Passcode", style: boldTextStyle()),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildListTileForSetting(
                title: "Turn passcode on",
                trailing: Switch(value: false, onChanged: (val) {}),
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Change passcode",
                isEnable: false,
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Erase data",
                trailing: const Switch(value: false, onChanged: null),
                subTitle: "Erase all $AppName data from this device after 10 failed passcode attempts",
                isEnable: false,
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Fingerprint unlock",
                subTitle: "Unlock the $AppName app with your fingerprint",
                trailing: const Switch(value: false, onChanged: null),
                isEnable: false,
              ),
              buildDivider(),
            ],
          ).paddingOnly(left: 4, top: 8),
        ),
      ),
    );
  }
}

import 'package:mcloud/screens/mCWalkthroughScreen2.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkthroughScreen1 extends StatelessWidget {
  const WalkthroughScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(""),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(CSmCloudLogo),
              Wrap(
                children: [
                  Text(
                    "mCloud works best with files. Do you want to upload some photos?",
                    textAlign: TextAlign.center,
                    style: boldTextStyle(size: 23),
                  ).paddingTop(20),
                ],
              ),
              Container(
                height: 50,
                decoration: const BoxDecoration(color: CSDarkBlueColor),
                child: Text(
                  'Select photos to upload',
                  style: boldTextStyle(color: Colors.white, size: 17),
                ).center(),
              ).paddingTop(20).onTap(() {}),
              TextButton(
                onPressed: () {
                  const WalkthroughScreen2().launch(context);
                },
                child: Text("Skip", style: boldTextStyle(size: 17, color: CSDarkBlueColor)),
              ).paddingTop(10)
            ],
          ).paddingAll(25),
        ),
      ),
    );
  }
}

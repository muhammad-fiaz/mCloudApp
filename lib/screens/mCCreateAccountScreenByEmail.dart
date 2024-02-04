import 'package:mcloud/screens/mCSignInScreen.dart';
import 'package:mcloud/screens/mCWalkthroughScreen1.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateAccountScreenByEmail extends StatefulWidget {
  static String tag = '/CreateAccountScreenByEmail';

  const CreateAccountScreenByEmail({super.key});

  @override
  CreateAccountScreenByEmailState createState() => CreateAccountScreenByEmailState();
}

class CreateAccountScreenByEmailState extends State<CreateAccountScreenByEmail> {
  bool? checked = false;

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
      appBar: appBarWidget("Create a mCloud Account"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(CSGoogleLogo, height: 50, width: 50),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("John Doe", style: boldTextStyle(size: 16)),
                  const Text(
                    "john@gmail.com",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ]).paddingLeft(30),
              ],
            ).paddingOnly(bottom: 15, top: 20, left: 20, right: 20),
            Wrap(
              children: [
                RichText(
                    text: TextSpan(
                        text: "Looks like there is no mCloud account with the email address ",
                        style: primaryTextStyle(size: 19),
                        children: [TextSpan(text: "example@gmail.com.", style: boldTextStyle(size: 19)), const TextSpan(text: " Would you like to create one?")]))
              ],
            ).paddingOnly(bottom: 15, left: 20, right: 20),
            buildDivider(isFull: true),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Checkbox(
                      value: checked,
                      checkColor: CSDarkBlueColor,
                      onChanged: (val) {
                        setState(() {
                          checked = val;
                        });
                      },
                      activeColor: CSGreyColor),
                  RichText(
                    text: const TextSpan(
                      text: "I agree to the ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "mCloud terms",
                          style: TextStyle(
                            color: CSDarkBlueColor,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildDivider(isFull: true),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: context.width() * 0.9,
              decoration: boxDecorationRoundedWithShadow(
                5,
                backgroundColor: checked! ? CSDarkBlueColor : CSGreyColor,
                spreadRadius: 1,
                blurRadius: 0,
                shadowColor: Colors.grey,
                offset: const Offset(0, 1),
              ),
              height: context.width() * 0.13,
              child: Text("Create Account", style: boldTextStyle(color: Colors.white)),
            ).onTap(() {
              const WalkthroughScreen1().launch(context);
            }).paddingTop(10),
            TextButton(
              onPressed: () {
                const SignInScreen().launch(context);
                finish(context);
              },
              child: Text(
                "Already have an account?",
                style: boldTextStyle(size: 17, color: CSDarkBlueColor),
              ),
            ).paddingTop(10)
          ],
        ),
      ),
    );
  }
}

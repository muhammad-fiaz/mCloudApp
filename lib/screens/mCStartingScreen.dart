import 'package:mcloud/screens/mCCreateAccountScreenByEmail.dart';
import 'package:mcloud/screens/mCDashboardScreen.dart';
import 'package:mcloud/screens/mCSignInScreen.dart';
import 'package:mcloud/screens/mCSignUpScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StartingScreen extends StatefulWidget {
  static String tag = '/StartingScreen';

  const StartingScreen({super.key});

  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Send Videos from the Air', style: boldTextStyle(size: 20)),
              50.height,
              Image.asset(CSmCloudLogo, height: 200, width: 200),
              50.height,
              googleSignInWidget().onTap(() {
                const DashboardScreen().launch(context);
              }),
              15.height,
              appleSignInWidget().onTap(() {
                const CreateAccountScreenByEmail().launch(context);
              }),
              15.height,
              authButtonWidget("Sign Up").onTap(() {
                const SignUpScreen().launch(context);
              }),
              20.height,
              RichText(
                text: const TextSpan(
                  text: "Already have an account?",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(text: " Sign In", style: TextStyle(color: CSDarkBlueColor)),
                  ],
                ),
              ).onTap(
                () {
                  const SignInScreen().launch(context);
                },
              ),
            ],
          ).paddingAll(16.0),
        ),
      ),
    );
  }
}

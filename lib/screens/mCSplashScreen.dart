import 'package:mcloud/screens/mCStartingScreen.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    await Future.delayed(const Duration(seconds: 2));
    finish(context);
    
    const StartingScreen().launch(context);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorFromHex('#FFFFFF'),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(CSmCloudLogo, height: 150, width: 150).center(),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('From', style: secondaryTextStyle()),
                Text(AppName, style: boldTextStyle(size: 25, color: Colors.black)),
              ],
            ).paddingBottom(16),
          )
        ],
      ),
    );
  }
}

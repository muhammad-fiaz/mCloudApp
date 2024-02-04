import 'package:mcloud/screens/mCDashboardScreen.dart';
import 'package:mcloud/screens/mCSignUpScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSCommonAppBar(context, title: "Sign in to $AppName"),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter email address";
                    } else if (!val.validateEmail()) {
                      return "Please enter valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildInputDecoration("Email"),
                ),
                20.height,
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: buildInputDecoration("Password"),
                ),
                20.height,
                authButtonWidget("Sign In").onTap(() {
                  if (_formKey.currentState!.validate()) {
                    DashboardScreen().launch(context);
                  }
                }),
                15.height,
                googleSignInWidget(),
                15.height,
                appleSignInWidget(),
                20.height,
                TextButton(
                  onPressed: () {
                    const SignUpScreen().launch(context);
                  },
                  child: Text(
                    "Sign up for mCloud",
                    style: boldTextStyle(
                      size: 17,
                      color: CSDarkBlueColor,
                    ),
                  ),
                ),
                20.height,
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Having trouble signing in?",
                    style: boldTextStyle(
                      size: 17,
                      color: CSDarkBlueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.black, width: 1.5),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: CSGreyColor,
        ),
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

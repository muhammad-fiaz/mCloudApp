// Importing necessary packages and models
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/screens/mCSplashScreen.dart';
import 'package:flutter/material.dart';

// List to store data for mCloud
List<DataModel> getmCloudList = getmCloudData();

// List to store data for CSDrawer
List<DrawerModel> getCSDrawerList = getCSDrawer();

// Main function to run the application
void main() {
  runApp(MyApp());
}

// MyApp class which is a StatelessWidget
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the first widget that receives the execution flow.
    // It's the root of your widget tree.
    return const MaterialApp(
      title: 'Cloud Storage', // Title of the application
      home: SplashScreen(), // Home page of the application
      debugShowCheckedModeBanner: false, // Disabling the debug banner
    );
  }
}
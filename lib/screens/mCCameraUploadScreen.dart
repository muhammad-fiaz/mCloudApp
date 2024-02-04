import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CameraUploadScreen extends StatefulWidget {
  static String tag = '/CameraUploadScreen';

  const CameraUploadScreen({super.key});

  @override
  CameraUploadScreenState createState() => CameraUploadScreenState();
}

class CameraUploadScreenState extends State<CameraUploadScreen> {
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
                title: Text("Camera uploads", style: boldTextStyle()),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildListTileForSetting(
                title: "Camera uploads",
                subTitle: "Photos will upload to the Camera Uploads folder in your personal $AppName",
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Upload video",
                subTitle: "Videos will upload to the Camera Uploads folder in your personal $AppName",
                trailing: const Switch(value: false, onChanged: null),
                isEnable: false,
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Background uploading",
                subTitle: "$AppName will upload when the battery level is greater than 30%",
                isEnable: false,
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Use data for camera uploads",
                subTitle: "Photos will upload when you're connected to Wi-Fi",
                trailing: const Switch(value: false, onChanged: null),
                isEnable: false,
              ),
              buildDivider(),
              buildListTileForSetting(
                title: "Use data plan",
                subTitle: "For all files",
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

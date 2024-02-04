import 'package:mcloud/component/DisplayDataInListViewComponents.dart';
import 'package:mcloud/component/DrawerComponents.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OfflineScreen extends StatefulWidget {
  static String tag = '/OfflineScreen';

  const OfflineScreen({super.key});

  @override
  OfflineScreenState createState() => OfflineScreenState();
}

class OfflineScreenState extends State<OfflineScreen> {
  List<DataModel> onlyDownloadData() {
    List<DataModel> offlineData = [];
    for (var element in getmCloudList) {
      if (element.isDownload) {
        offlineData.add(element);
      }
    }
    return offlineData;
  }

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

  Future<void> refreshList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline", style: boldTextStyle()),
      ),
      drawer: const DrawerComponents(),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: onlyDownloadData().isNotEmpty
            ? SingleChildScrollView(
                child: DisplayDataInListViewComponents(
                  listOfData: onlyDownloadData(),
                  isSelect: false,
                  isCopyOrMove: false,
                  isSelectAll: false,
                  selectedItem: 0,
                  onListChanged: () {
                    setState(() {});
                  },
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(CSOfflineImg, height: 120, width: 120),
                  Text(
                    "Get to your files offline",
                    style: boldTextStyle(size: 20),
                  ).paddingOnly(top: 20, bottom: 10),
                  Wrap(
                    children: [
                      const Text(
                        "Files you make available offline will show up here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ).paddingOnly(top: 10, bottom: 10),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Learn more",
                      style: TextStyle(color: CSDarkBlueColor),
                    ),
                  )
                ],
              ).center(),
      ),
    );
  }
}

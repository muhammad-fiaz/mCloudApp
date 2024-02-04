import 'package:mcloud/component/DisplayDataInListViewComponents.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SharedScreen extends StatefulWidget {
  static String tag = '/SharedScreen';

  const SharedScreen({super.key});

  @override
  SharedScreenState createState() => SharedScreenState();
}

class SharedScreenState extends State<SharedScreen> {
  List<DataModel> onlySharedData() {
    List<DataModel> sharedData = [];
    for (var element in getmCloudList) {
      if (element.isShared) {
        sharedData.add(element);
      }
    }
    return sharedData;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: onlySharedData().isNotEmpty
            ? DisplayDataInListViewComponents(
                listOfData: onlySharedData(),
                isSelect: false,
                isSelectAll: false,
                selectedItem: 0,
                isCopyOrMove: false,
                onListChanged: () {
                  setState(() {});
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(CSOfflineImg, height: 120, width: 120),
                    Text("Aim for the shared", style: boldTextStyle(size: 20)).paddingOnly(top: 20, bottom: 10),
                    Wrap(
                      children: [
                        const Text(
                          "After you share an item, it'll show up here, so it's easier to get to",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ).paddingSymmetric(vertical: 10, horizontal: 50),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

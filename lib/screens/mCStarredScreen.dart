import 'package:mcloud/component/DisplayDataInListViewComponents.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StarredScreen extends StatefulWidget {
  static String tag = '/StarredScreen';

  const StarredScreen({super.key});

  @override
  StarredScreenState createState() => StarredScreenState();
}

class StarredScreenState extends State<StarredScreen> {
  List<DataModel> onlyStarredData() {
    List<DataModel> starredData = [];

    for (var element in getmCloudList) {
      if (element.isStared) {
        starredData.add(element);
      }
    }

    return starredData;
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
        child: DisplayDataInListViewComponents(
          listOfData: onlyStarredData(),
          isSelect: false,
          isSelectAll: false,
          selectedItem: 0,
          isCopyOrMove: false,
          onListChanged: () {
            setState(() {});
          },
        ).visible(
          onlyStarredData().isNotEmpty,
          defaultWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(CSOfflineImg, height: 120, width: 120),
              Text("Aim for the stars", style: boldTextStyle(size: 20)).paddingOnly(top: 20, bottom: 10),
              const Text(
                "After you star an item, it'll show up here, so it's easier to get to",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ).paddingSymmetric(vertical: 10, horizontal: 50),
            ],
          ),
        ),
      ),
    );
  }
}

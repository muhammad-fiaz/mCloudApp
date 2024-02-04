import 'package:mcloud/component/DisplayDataInListViewComponents.dart';
import 'package:mcloud/component/SearchBar.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CopyAndMoveComponents extends StatefulWidget {
  static String tag = '/CopyAndMoveComponents';

  final List<DataModel>? listOfData;
  final String? appBarTitle;

  const CopyAndMoveComponents({Key? key, this.listOfData, this.appBarTitle}) : super(key: key);

  @override
  CopyAndMoveComponentsState createState() => CopyAndMoveComponentsState();
}

class CopyAndMoveComponentsState extends State<CopyAndMoveComponents> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close, color: CSDarkBlueColor),
            onPressed: () {
              finish(context);
            }),
        title: Text(widget.appBarTitle!),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: CSDarkBlueColor),
              onPressed: () {
                showSearch(context: context, delegate: CSSearchBar(hintText: "Searching in mCloud", listData: getmCloudList));
              }),
          IconButton(
              icon: const Icon(Icons.create_new_folder, color: CSDarkBlueColor),
              onPressed: () async {
                var folderName = await buildCreateFolderDialog(context);
                if (folderName != null) {
                  getmCloudList.add(DataModel(fileName: folderName, fileUrl: CSFolderIcon, isFolder: true));
                }
                setState(() {});
              }),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              width: size.width,
              height: size.height * 0.8,
              child: SingleChildScrollView(
                  child: DisplayDataInListViewComponents(
                listOfData: widget.listOfData,
                isSelectAll: false,
                isSelect: false,
                isCopyOrMove: true,
              ))),
          Positioned(
            bottom: 5,
            right: 10,
            child: MaterialButton(
              height: 50,
              minWidth: 80,
              color: CSDarkBlueColor,
              onPressed: () {},
              child: Text(
                "Paste",
                style: boldTextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

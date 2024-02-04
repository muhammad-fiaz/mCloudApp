import 'package:mcloud/component/CopyAndMoveComponents.dart';
import 'package:mcloud/component/DisplayDataInGridViewComponents.dart';
import 'package:mcloud/component/DisplayDataInListViewComponents.dart';
import 'package:mcloud/component/DrawerComponents.dart';
import 'package:mcloud/component/SearchBar.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class CommonFileComponents extends StatefulWidget {
  static String tag = '/CommonFileComponents';

  final String? appBarTitle;

  const CommonFileComponents({Key? key, this.appBarTitle}) : super(key: key);

  @override
  CommonFileComponentsState createState() => CommonFileComponentsState();
}

class CommonFileComponentsState extends State<CommonFileComponents> {
  CrossFadeState state = CrossFadeState.showFirst;
  Sorting? defaultSortingType = Sorting.Name;
  int selectedItem = 0;
  bool isSelect = false;
  bool isSelectAll = false;

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

  void selectAll() {
    isSelectAll = !isSelectAll;

    for (var element in getmCloudList) {
      element.isFileSelect = isSelectAll;
    }

    selectedItem = isSelectAll ? getmCloudList.length : 0;
    setState(() {});
  }

  List<Widget> actionBarWidgets() {
    List<Widget> listOfActionBarWidgets = [];
    if (selectedItem == 0) {
      listOfActionBarWidgets.add(
        IconButton(
          color: CSDarkBlueColor,
          icon: const Icon(Icons.done_all),
          onPressed: () => setState(() => selectAll()),
        ),
      );
    } else {
      listOfActionBarWidgets.add(
        IconButton(
          color: CSDarkBlueColor,
          icon: const Icon(Icons.done_all),
          onPressed: () => setState(() => selectAll()),
        ),
      );
      listOfActionBarWidgets.add(
        IconButton(color: CSDarkBlueColor, icon: const Icon(MaterialCommunityIcons.file_download), onPressed: () {}),
      );
      listOfActionBarWidgets.add(PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: CSDarkBlueColor),
          onSelected: (dynamic val) async {
            if (val == 2) {
              CopyAndMoveComponents(
                appBarTitle: "Copy $selectedItem items to",
                listOfData: getmCloudList,
              ).launch(context);
            }
            if (val == 3) {
              CopyAndMoveComponents(
                appBarTitle: "Move $selectedItem items to",
                listOfData: getmCloudList,
              ).launch(context);
            }
            if (val == 4) {
              bool isSelectedFileDeleted = await (buildDeleteSelectedFileDialog(context, "Delete $selectedItem items?"));
              if (isSelectedFileDeleted) {
                getmCloudList.removeWhere((element) => element.isFileSelect == true);
                finish(context);

                const CommonFileComponents(
                  appBarTitle: AppName,
                ).launch(context);
              }
              setState(() {});
            }
          },
          itemBuilder: (context) =>
          [
            const PopupMenuItem(value: 1, child: Text("Save to Device")),
            const PopupMenuItem(value: 2, child: Text("Copy")),
            const PopupMenuItem(value: 3, child: Text("Move")),
            const PopupMenuItem(value: 4, child: Text("Delete")),
          ]));
    }
    return listOfActionBarWidgets;
  }

  void ascendingOrderList() {
    getmCloudList.sort((a, b) => a.fileName!.toLowerCase().compareTo(b.fileName!.toLowerCase()));
  }

  void descendingOrderList() {
    getmCloudList = getmCloudList.reversed.toList();
  }

  Future showSortingType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (BuildContext ctx, StateSetter state) {
            return Wrap(children: [
              Container(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text("Sort By", style: primaryTextStyle(size: 16)),
                  10.height,
                  ListTile(
                    onTap: () {
                      ascendingOrderList();
                      defaultSortingType = Sorting.Name;
                      setState(() {});
                      finish(context);
                    },
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Name"),
                    leading: const Icon(Icons.sort_by_alpha),
                    trailing: Radio(
                        visualDensity: const VisualDensity(vertical: -2),
                        value: Sorting.Name,
                        groupValue: defaultSortingType,
                        onChanged: (Sorting? val) =>
                            state(() {
                              ascendingOrderList();
                              defaultSortingType = val;
                              setState(() {});
                              finish(context);
                            })),
                  ),
                  ListTile(
                    onTap: () {
                      descendingOrderList();
                      defaultSortingType = Sorting.Modified;
                      setState(() {});
                      finish(context);
                    },
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Modified"),
                    leading: const Icon(Icons.access_time),
                    trailing: Radio(
                        visualDensity: const VisualDensity(vertical: -2),
                        value: Sorting.Modified,
                        groupValue: defaultSortingType,
                        onChanged: (Sorting? val) =>
                            state(() {
                              descendingOrderList();
                              defaultSortingType = val;
                              setState(() {});
                              finish(context);
                            })),
                  ),
                ]).paddingAll(16),
              ),
            ]);
          });
        });
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSelect) {
          setState(() {
            isSelect = false;
          });
        } else {
          finish(context);
        }
        return false;
      },
      child: Scaffold(
        drawer: isSelect ? null : const DrawerComponents(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                leading: isSelect
                    ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () =>
                      setState(() {
                        isSelect = false;
                        for (var element in getmCloudList) {
                          element.isFileSelect = false;
                        }
                        selectedItem = 0;
                      }),
                )
                    : null,
                actions: isSelect
                    ? actionBarWidgets()
                    : [
                  IconButton(
                    color: CSDarkBlueColor,
                    icon: const Icon(Icons.search),
                    onPressed: () => showSearch(context: context, delegate: CSSearchBar(hintText: "Searching in mCloud", listData: getmCloudList)),
                  ),
                  IconButton(
                    color: CSDarkBlueColor,
                    icon: const Icon(Feather.check_square, size: 20),
                    onPressed: () => setState(() => isSelect = true),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, color: CSDarkBlueColor),
                    onSelected: (dynamic val) {
                      if (val == 1) showSortingType(context);
                    },
                    itemBuilder: (context) => [const PopupMenuItem(value: 1, child: Text("Sort"))],
                  ),
                ],
                expandedHeight: isSelect ? 0 : 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: isSelect
                      ? selectedItem == 0
                      ? Text("Select items", style: boldTextStyle(color: black, size: 18))
                      : Text("$selectedItem selected", style: boldTextStyle(color: black, size: 18))
                      : Text(widget.appBarTitle!, style: boldTextStyle(color: black, size: 18)),
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: refreshList,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.appBarTitle != AppName
                      ? !isSelect
                      ? TextButton(
                    style: TextButton.styleFrom(visualDensity: const VisualDensity(horizontal: -4, vertical: -2)),
                    onPressed: () {},
                    child: Text("Only you", style: primaryTextStyle(size: 16)),
                  ).paddingLeft(12)
                      : 0.height
                      : 0.height,
                  widget.appBarTitle != AppName
                      ? !isSelect
                      ? MaterialButton(
                    onPressed: () {},
                    color: CSDarkBlueColor,
                    padding: const EdgeInsets.all(0),
                    minWidth: 80,
                    elevation: 0,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -1),
                    child: Text("Share", style: boldTextStyle(color: white)),
                  ).paddingLeft(16)
                      : 0.height
                      : 0.height,
                  10.height,
                  isSelect
                      ? 0.height
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [Text(defaultSortingType.toString().substring(defaultSortingType.toString().indexOf('.') + 1)), const Icon(Icons.keyboard_arrow_down)],
                      ).onTap(() => showSortingType(context)),
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          iconSize: 12,
                          color: Colors.blueGrey,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          icon: state == CrossFadeState.showFirst ? const Icon(FontAwesome.list_ul) : const Icon(AntDesign.appstore1),
                          onPressed: () {
                            setState(() => state = state == CrossFadeState.showFirst ? CrossFadeState.showSecond : CrossFadeState.showFirst);
                          })
                    ],
                  ).paddingOnly(right: 10, left: 16),
                  isSelect ? 0.height : buildDivider(isFull: true),
                  getmCloudList.isNotEmpty
                      ? AnimatedCrossFade(
                    duration: const Duration(milliseconds: 50),
                    crossFadeState: state,
                    firstChild: DisplayDataInGridViewComponents(
                      selectedItem: selectedItem,
                      isSelectAll: isSelectAll,
                      listOfData: getmCloudList,
                      isSelect: isSelect,
                      onChange: (int? itemCount, bool? selectAll) {
                        selectedItem = itemCount!;
                        isSelectAll = selectAll!;
                        setState(() {});
                      },
                    ),
                    secondChild: DisplayDataInListViewComponents(
                      isSelect: isSelect,
                      isSelectAll: isSelectAll,
                      listOfData: getmCloudList,
                      selectedItem: selectedItem,
                      isCopyOrMove: false,
                      onChange: (int? itemCount, bool? selectAll) {
                        selectedItem = itemCount!;
                        isSelectAll = selectAll!;
                        setState(() {});
                      },
                      onListChanged: () => setState(() {}),
                    ),
                  )
                      : SizedBox(
                    height: 200,
                    child: Text("This folder is empty", style: primaryTextStyle(color: Colors.grey)).center(),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: isSelect
            ? null
            : FloatingActionButton(
          onPressed: () async {
            await showBottomSheetForAddingData(context);
            setState(() {});
          },
          backgroundColor: CSDarkBlueColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

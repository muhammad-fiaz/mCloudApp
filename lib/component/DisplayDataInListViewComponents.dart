import 'package:mcloud/component/CommonFileComponents.dart';
import 'package:mcloud/component/FileAndFolderEditingComponents.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class DisplayDataInListViewComponents extends StatefulWidget {
  static String tag = '/DisplayDataInListViewComponents';
  List<DataModel>? listOfData;
  bool? isSelect;
  bool? isSelectAll;
  bool? isCopyOrMove;
  int? selectedItem;
  Function(int?, bool?)? onChange;
  Function()? onListChanged;

  DisplayDataInListViewComponents({Key? key, this.listOfData, this.isSelect, this.isSelectAll, this.selectedItem, this.onChange, this.onListChanged, this.isCopyOrMove}) : super(key: key);

  @override
  DisplayDataInListViewComponentsState createState() => DisplayDataInListViewComponentsState();
}

class DisplayDataInListViewComponentsState extends State<DisplayDataInListViewComponents> {
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
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          enabled: widget.isCopyOrMove!
              ? widget.listOfData![index].isFolder
                  ? true
                  : false
              : true,
          contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
          onTap: () {
            if (widget.listOfData![index].isFolder) {
              widget.isSelect!
                  ? selectFileAndFolders(index)
                  : widget.isCopyOrMove!
                      ? toasty(context, "Copied ${widget.listOfData![index].fileName}")
                      : CommonFileComponents(appBarTitle: widget.listOfData![index].fileName).launch(context);
            } else {
              if (widget.isSelect!) selectFileAndFolders(index);
            }
          },
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          title: Row(
            children: [
              Text(widget.listOfData![index].fileName!),
              widget.listOfData![index].isStared
                  ? IconButton(
                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                      iconSize: 18,
                      color: CSDarkBlueColor,
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        widget.listOfData![index].isStared = false;
                        setState(() {});
                      },
                    )
                  : 0.width,
            ],
          ),
          leading: Image.asset(widget.listOfData![index].fileUrl, height: 30, width: 30),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              !widget.isSelect!
                  ? Row(
                      children: [
                        widget.listOfData![index].isDownload
                            ? IconButton(
                                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                iconSize: 18,
                                icon: const Icon(MaterialIcons.offline_pin),
                                onPressed: () {
                                  widget.listOfData![index].isDownload = false;
                                  setState(() {});
                                },
                              )
                            : 0.width,
                        !widget.isCopyOrMove!
                            ? IconButton(
                                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                icon: const Icon(Icons.more_vert),
                                iconSize: 18,
                                onPressed: () async {
                                  await showBottomSheetForFileAndFolderEditingOption(context, widget.listOfData![index]);
                                  widget.onListChanged!.call();
                                  setState(() {});
                                })
                            : 0.width,
                      ],
                    )
                  : Row(
                      children: [
                        widget.listOfData![index].isDownload
                            ? IconButton(
                                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                iconSize: 18,
                                icon: const Icon(MaterialIcons.offline_pin),
                                onPressed: () {},
                              )
                            : 0.width,
                        Checkbox(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          value: widget.listOfData![index].isFileSelect,
                          onChanged: (val) {
                            setState(() {
                              widget.isSelectAll = false;
                              widget.listOfData![index].isFileSelect = val;
                              val! ? widget.selectedItem = widget.selectedItem! + 1 : widget.selectedItem = widget.selectedItem! - 1;
                              widget.onChange!.call(widget.selectedItem, widget.isSelectAll);
                            });
                          },
                        ),
                      ],
                    ),
            ],
          ),
          subtitle: widget.listOfData![index].fileUrl != CSFolderIcon ? const Text("size and time display here") : null,
        );
      },
      itemCount: widget.listOfData!.length,
    );
  }

  void selectFileAndFolders(int index) {
    setState(() {
      widget.isSelectAll = false;
      widget.listOfData![index].isFileSelect = !widget.listOfData![index].isFileSelect!;
      widget.listOfData![index].isFileSelect! ? widget.selectedItem = widget.selectedItem! + 1 : widget.selectedItem = widget.selectedItem! - 1;
      widget.onChange!.call(widget.selectedItem, widget.isSelectAll);
    });
  }
}

import 'package:mcloud/component/CommonFileComponents.dart';
import 'package:mcloud/component/FileAndFolderEditingComponents.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class DisplayDataInGridViewComponents extends StatefulWidget {
  static String tag = '/DisplayDataInGridViewComponents';
  List<DataModel>? listOfData;
  bool? isSelect;
  bool? isSelectAll;
  int? selectedItem;
  Function(int?, bool?)? onChange;

  DisplayDataInGridViewComponents({Key? key, this.listOfData, this.isSelect, this.isSelectAll, this.selectedItem, this.onChange}) : super(key: key);

  @override
  DisplayDataInGridViewComponentsState createState() => DisplayDataInGridViewComponentsState();
}

class DisplayDataInGridViewComponentsState extends State<DisplayDataInGridViewComponents> {
  bool isChecked = false;

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
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: widget.listOfData!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: widget.isSelect! ? 0.7 : 0.79, crossAxisSpacing: 5),
      itemBuilder: (context, index) {
        return Container(
          //color: Colors.amber,
          padding: widget.isSelect! ? const EdgeInsets.all(0) : const EdgeInsets.all(4),
          width: context.width() / 2,
          margin: const EdgeInsets.only(bottom: 5),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isSelect!
                  ? Container(
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      width: context.width() / 2,
                      child: Checkbox(
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
                    )
                  : 0.height,
              SizedBox(
                width: context.width() / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.listOfData![index].fileUrl,
                      height: 150,
                      width: 130,
                      fit: BoxFit.cover,
                    ).onTap(() {
                      if (widget.listOfData![index].fileUrl == CSFolderIcon) {
                        widget.isSelect!
                            ? selectFileAndFolders(index)
                            : CommonFileComponents(
                                appBarTitle: widget.listOfData![index].fileName,
                              ).launch(context);
                      } else {
                        if (widget.isSelect!) {
                          selectFileAndFolders(index);
                        }
                      }
                    }),
                    Text(widget.listOfData![index].fileName!).paddingTop(8),
                    widget.isSelect!
                        ? Wrap(
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
                          )
                        : Wrap(
                            children: [
                              widget.listOfData![index].isDownload
                                  ? IconButton(
                                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                      iconSize: 18,
                                      icon: const Icon(MaterialIcons.offline_pin),
                                      onPressed: () {},
                                    )
                                  : 0.width,
                              widget.listOfData![index].isStared
                                  ? IconButton(
                                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                      iconSize: 18,
                                      color: CSDarkBlueColor,
                                      icon: const Icon(Icons.star),
                                      onPressed: () {},
                                    )
                                  : 0.width,
                              IconButton(
                                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                                iconSize: 18,
                                icon: const Icon(MaterialCommunityIcons.dots_vertical_circle_outline),
                                onPressed: () async {
                                  await showBottomSheetForFileAndFolderEditingOption(
                                    context,
                                    widget.listOfData![index],
                                  );
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ).onTap(
          () {
            widget.isSelect! ? 0.height : 0.height;
          },
        );
      },
    );
  }

  void selectFileAndFolders(int index) {
    setState(
      () {
        widget.isSelectAll = false;
        widget.listOfData![index].isFileSelect = !widget.listOfData![index].isFileSelect!;
        widget.listOfData![index].isFileSelect! ? widget.selectedItem = widget.selectedItem! + 1 : widget.selectedItem = widget.selectedItem! - 1;
        widget.onChange!.call(widget.selectedItem, widget.isSelectAll);
      },
    );
  }
}

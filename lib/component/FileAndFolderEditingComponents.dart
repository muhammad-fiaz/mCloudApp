import 'package:mcloud/component/CopyAndMoveComponents.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/screens/mCUpgradeAccountScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share/share.dart';

Future showBottomSheetForFileAndFolderEditingOption(BuildContext context, DataModel dataModel) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => Container(
      padding: const EdgeInsets.only(top: 20),
      child: StatefulBuilder(
        builder: (BuildContext ctx, StateSetter state) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            expand: false,
            maxChildSize: 1.0,
            builder: (_, scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                      lisTileForFileEditingOption(
                        title: dataModel.fileName!,
                        leading: dataModel.isFolder ? Image.asset(CSFolderIcon, width: 40, height: 40) : Image.asset(CSFileImg, width: 40, height: 40),
                        subTitle: dataModel.isFolder ? AppName : "date and size of the file",
                      ),
                      buildDivider(isFull: true),
                      dataModel.isFolder
                          ? 0.height
                          : lisTileForFileEditingOption(title: "Copy link", leading: blackIcon(Icons.link)).onTap(() {
                              toastLong("Link is ready to be used");
                              finish(context);
                            }),
                      lisTileForFileEditingOption(title: "Share", leading: blackIcon(Icons.share)).onTap(() {
                        finish(context);
                        showBottomSheetForSharingData(context, dataModel);
                      }),
                      dataModel.isFolder ? 0.height : lisTileForFileEditingOption(title: "Manage access", leading: blackIcon(Icons.settings)),
                      buildDivider(isFull: true),
                      lisTileForFileEditingOption(
                        title: "Make available offline",
                        leading: blackIcon(Icons.arrow_circle_down),
                        trailing: dataModel.isFolder
                            ? TextButton(
                                onPressed: () {
                                  finish(context);
                                  const UpgradeAccountScreen().launch(context);
                                },
                                child: Text("Upgrade", style: boldTextStyle(color: CSDarkBlueColor)))
                            : Switch(
                                value: dataModel.isDownload,
                                onChanged: (val) => state(() {
                                      dataModel.isDownload = val;
                                      finish(context, dataModel);
                                    })),
                      ),
                      buildDivider(isFull: true),
                      dataModel.isStared
                          ? lisTileForFileEditingOption(title: "Unstar", leading: blackIcon(MaterialCommunityIcons.star_off)).onTap(() {
                              state(() {
                                dataModel.isStared = false;
                                finish(context);
                              });
                            })
                          : lisTileForFileEditingOption(title: "Star", leading: blackIcon(Icons.star_border)).onTap(() {
                              state(() {
                                dataModel.isStared = true;
                                finish(context);
                              });
                            }),
                      lisTileForFileEditingOption(title: "Rename", leading: blackIcon(Icons.edit)).onTap(() async {
                        TextEditingController controller = TextEditingController();
                        controller.text = dataModel.fileName!;
                        controller = await (buildRenameDialog(context, controller));
                        if (controller.text != dataModel.fileName) {
                          dataModel.fileName = controller.text;
                          finish(context);
                        }
                      }),
                      lisTileForFileEditingOption(
                        title: "Copy",
                        leading: blackIcon(Icons.copy),
                      ).onTap(
                        () {
                          finish(context);
                          CopyAndMoveComponents(
                            appBarTitle: "Copy ${dataModel.fileName} to",
                            listOfData: getmCloudList,
                          ).launch(context);
                        },
                      ),
                      lisTileForFileEditingOption(
                        title: "Move",
                        leading: blackIcon(Icons.drive_file_move),
                      ).onTap(
                        () {
                          finish(context);
                          CopyAndMoveComponents(
                            appBarTitle: "Move ${dataModel.fileName} to",
                            listOfData: getmCloudList,
                          ).launch(context);
                        },
                      ),
                      dataModel.isFolder
                          ? 0.height
                          : lisTileForFileEditingOption(
                              title: "Open with...",
                              leading: blackIcon(Icons.open_in_new),
                            ),
                      dataModel.isFolder
                          ? 0.height
                          : lisTileForFileEditingOption(
                              title: "Export",
                              leading: blackIcon(Icons.double_arrow),
                            ).onTap(() {
                              Share.share(dataModel.fileName!);
                            }),
                      dataModel.isShared ? 0.height : buildDivider(isFull: true),
                      dataModel.isShared
                          ? 0.height
                          : lisTileForFileEditingOption(
                              title: "Delete",
                              leading: const Icon(Icons.delete, color: Colors.red),
                              color: Colors.red,
                            ).onTap(
                              () async {
                                //success
                                bool isFileDeleted = await (buildDeleteDialog(context, dataModel));
                                if (isFileDeleted) {
                                  getmCloudList.removeWhere(
                                    (element) {
                                      return element.fileName == dataModel.fileName;
                                    },
                                  );
                                }
                                finish(context);
                              },
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  );
}

Widget lisTileForFileEditingOption({required String title, String subTitle = "", Widget? trailing, Color? color, Widget? leading}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    visualDensity: const VisualDensity(horizontal: -3, vertical: -4),
    title: Text(title, style: TextStyle(color: color.toString().isEmpty ? Colors.black : color)),
    subtitle: subTitle.isEmpty ? null : Text(subTitle),
    trailing: trailing,
    leading: leading,
  );
}

Widget blackIcon(IconData icon) {
  return Icon(
    icon,
    color: Colors.black,
  );
}

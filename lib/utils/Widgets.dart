import 'package:mcloud/component/ShareComponents.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share/share.dart';

// ignore: non_constant_identifier_names
AppBar CSCommonAppBar(BuildContext context, {String title = 'Enter AppName', bool isBack = true}) {
  return AppBar(
    title: Text(title, style: boldTextStyle()),
    leading: isBack
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              finish(context);
            },
          )
        : 0.height,
  );
}

InputDecoration buildInputDecoration(String labelText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.black, width: 1.5),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: CSGreyColor),
      borderRadius: BorderRadius.zero,
    ),
  );
}

Widget createBasicListTile({IconData? icon, required String text, Function? onTap}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
    onTap: onTap as void Function()?,
    title: Text(text, style: const TextStyle(fontSize: 16)),
    leading: Icon(icon, color: Colors.black, size: 22),
  );
}

Widget authButtonWidget(String btnTitle) {
  return Container(
    height: 50,
    padding: const EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: boxDecorationRoundedWithShadow(5, backgroundColor: CSDarkBlueColor, spreadRadius: 1, blurRadius: 0, shadowColor: Colors.grey, offset: const Offset(0, 1)),
    child: Text(
      btnTitle,
      style: boldTextStyle(color: Colors.white),
    ),
  );
}

Widget appleSignInWidget() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: boxDecorationRoundedWithShadow(5, backgroundColor: Colors.black, spreadRadius: 1, blurRadius: 0, shadowColor: Colors.grey, offset: const Offset(0, 1)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          CSAppleLogo,
          height: 30,
          width: 30,
        ),
        Text(
          "Sign in with Apple",
          style: boldTextStyle(color: Colors.white),
        ).center().expand(),
      ],
    ),
  );
}

Widget googleSignInWidget() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: boxDecorationRoundedWithShadow(5, backgroundColor: Colors.white, spreadRadius: 1, blurRadius: 0, shadowColor: Colors.grey, offset: const Offset(0, 1)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [Image.asset(CSGoogleLogo, height: 30, width: 30), Text("Sign in with Google", style: boldTextStyle(color: Colors.black)).center().expand()],
    ),
  );
}

Widget buildDivider({bool isFull = false}) {
  return const Divider(color: Colors.grey).paddingLeft(isFull ? 0 : 16);
}

Future showBottomSheetForAddingData(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext ctx) {
      return Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add to mCloud", style: TextStyle(fontSize: 15, color: Colors.grey)).paddingBottom(10),
                createBasicListTile(text: "Take a photo", icon: Icons.camera_alt).onTap(() {
                  ImagePicker().getImage(source: ImageSource.camera);
                }),
                createBasicListTile(text: "Scan Document", icon: Icons.my_library_books_outlined),
                createBasicListTile(text: "Upload photos or videos", icon: Icons.photo_album_rounded).onTap(() async {
                  PickedFile? imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
                  if (imageFile != null) {}
                  finish(context);
                }),
                const Divider(color: Colors.grey),
                createBasicListTile(text: "Create or upload file", icon: Icons.cloud_upload),
                createBasicListTile(text: "Create new folder", icon: Icons.folder).onTap(() async {
                  var folderName = await buildCreateFolderDialog(context);
                  if (folderName != null) {
                    getmCloudList.add(DataModel(fileName: folderName, fileUrl: CSFolderIcon, isFolder: true));
                    finish(context);
                  }
                }),
                const Divider(color: Colors.grey),
                createBasicListTile(text: "Add file from computer", icon: Icons.laptop_chromebook_outlined),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Future showBottomSheetForSharingData(BuildContext context, DataModel dataModel) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext ctx) {
      return Wrap(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: context.width(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      decoration: boxDecorationRoundedWithShadow(5, backgroundColor: Colors.white, spreadRadius: 1, blurRadius: 0, shadowColor: Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Share \"${dataModel.fileName}\"", style: boldTextStyle(size: 20)),
                          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
                        ],
                      ),
                    ),
                    10.height,
                    Text("Send to", style: boldTextStyle()).paddingLeft(16),
                    10.height,
                    TextField(
                      onTap: () {
                        hideKeyboard(context);
                        ShareComponents(dataModel: dataModel).launch(context);
                      },
                      style: primaryTextStyle(size: 20),
                      decoration: InputDecoration(
                        hintText: "Email, name or group",
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        hintStyle: secondaryTextStyle(color: Colors.grey),
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    10.height,
                    Text("Or share a link", style: boldTextStyle()).paddingSymmetric(horizontal: 16),
                    10.height,
                    ListTile(
                      //visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      leading: IconButton(icon: const Icon(Icons.link_rounded), onPressed: () {}),
                      title: const Text("No link created for view"),
                      trailing: Text("Create a link", style: boldTextStyle(color: CSDarkBlueColor)),
                      onTap: () {
                        Share.share("Share the file link");
                      },
                    ).paddingSymmetric(horizontal: 16),
                  ],
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Future buildRenameDialog(BuildContext context, TextEditingController controller) {
  bool isFileNameChange = false;
  String oldName = controller.text;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, state) {
          return AlertDialog(
            buttonPadding: const EdgeInsets.all(8),
            contentPadding: const EdgeInsets.fromLTRB(25, 16, 32, 8),
            insetPadding: const EdgeInsets.all(16),
            title: Text("Rename file", style: boldTextStyle(size: 24)),
            content: Wrap(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                  ),
                  onChanged: (val) {
                    if (val == oldName) {
                      isFileNameChange = false;
                    } else {
                      isFileNameChange = true;
                    }
                    state(() {});
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Cancel", style: boldTextStyle(size: 16, color: Colors.blueGrey)),
                onPressed: () {
                  finish(context, controller);
                },
              ),
              TextButton(
                child: Text("Rename", style: boldTextStyle(size: 16, color: isFileNameChange ? CSDarkBlueColor : Colors.grey)),
                onPressed: () {
                  finish(context, controller);
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future buildDeleteDialog(BuildContext context, DataModel dataModel) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.fromLTRB(25, 16, 32, 8),
        insetPadding: const EdgeInsets.all(16),
        title: Text(dataModel.fileName!, style: boldTextStyle(size: 24)),
        content: dataModel.isFolder ? const Text("Are you sure you want to delete this folder ?") : const Text("Are you sure you want to delete this item from your mCloud?"),
        actions: [
          TextButton(
            child: Text("Cancel", style: boldTextStyle(size: 16, color: Colors.grey)),
            onPressed: () {
              finish(context, false);
            },
          ),
          TextButton(
            child: Text("Delete", style: boldTextStyle(size: 16, color: CSDarkBlueColor)),
            onPressed: () {
              finish(context, true);
            },
          ),
        ],
      );
    },
  );
}

Future buildCommonDialog(BuildContext context, {String? title, String? content, String posBtn = "OK", String negBtn = "Cancel"}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.fromLTRB(25, 16, 32, 8),
        insetPadding: const EdgeInsets.all(16),
        title: title.isEmptyOrNull ? null : Text(title!, style: boldTextStyle(size: 24)),
        content: Text(content!),
        actions: [
          TextButton(
            child: Text(negBtn, style: boldTextStyle(size: 16, color: Colors.grey)),
            onPressed: () {
              finish(context, false);
            },
          ),
          TextButton(
            child: Text(posBtn, style: boldTextStyle(size: 16, color: CSDarkBlueColor)),
            onPressed: () {
              finish(context, true);
            },
          ),
        ],
      );
    },
  );
}

Future buildDeleteSelectedFileDialog(BuildContext context, String title) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.fromLTRB(25, 16, 32, 8),
        insetPadding: const EdgeInsets.all(16),
        title: Text(title, style: boldTextStyle(size: 24)),
        content: const Text("Are you sure you want to delete these item from your mCloud?"),
        actions: [
          TextButton(
            child: Text("Cancel", style: boldTextStyle(size: 16, color: Colors.grey)),
            onPressed: () {
              finish(context, false);
            },
          ),
          TextButton(
            child: Text("Delete", style: boldTextStyle(size: 16, color: CSDarkBlueColor)),
            onPressed: () {
              finish(context, true);
            },
          ),
        ],
      );
    },
  );
}

Future showBottomSheetForUpdatePhoto(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext ctx) {
      return Wrap(children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update account photo",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ).paddingBottom(10),
              createBasicListTile(text: "Choose from mCloud", icon: Icons.camera_alt),
              createBasicListTile(text: "Choose from gallery", icon: Icons.my_library_books_outlined).onTap(() {
                ImagePicker().getImage(source: ImageSource.gallery);
              }),
              createBasicListTile(text: "Use Camera", icon: Icons.photo_album_rounded).onTap(() {
                ImagePicker().getImage(source: ImageSource.camera);
              }),
            ],
          ).paddingAll(10),
        ),
      ]);
    },
  );
}

Future buildCreateFolderDialog(BuildContext context) {
  bool isBlank = false;
  TextEditingController controller = TextEditingController();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, state) {
          return AlertDialog(
            buttonPadding: const EdgeInsets.all(8),
            insetPadding: const EdgeInsets.all(16),
            title: Text("Create new folder", style: boldTextStyle(size: 20)),
            content: Row(
              children: [
                Image.asset(CSFolderIcon, height: 30, width: 30),
                10.width,
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      state(() {});
                      if (val.isEmpty) {
                        isBlank = false;
                      } else {
                        isBlank = true;
                      }
                    },
                    controller: controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      hintText: "Untitled folder",
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                child: Text("Cancel", style: boldTextStyle(size: 16, color: Colors.blueGrey)),
                onPressed: () {
                  finish(context);
                },
              ),
              TextButton(
                child: Text("Create", style: boldTextStyle(size: 16, color: isBlank ? CSDarkBlueColor : Colors.grey)),
                onPressed: () {
                  if (isBlank) finish(context, controller.text);
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Widget buildListTileForSetting({required String title, String subTitle = "", Widget? trailing, Widget? leading, Color? color, Function? onTap, bool isEnable = true}) {
  return ListTile(
    enabled: isEnable,
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    title: Text(title, style: TextStyle(color: color.toString().isEmpty ? Colors.black : color)),
    subtitle: subTitle.isEmpty ? null : Text(subTitle),
    trailing: trailing,
    leading: leading,
    onTap: onTap as void Function()?,
  );
}

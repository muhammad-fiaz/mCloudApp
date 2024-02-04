import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mcloud/component/DrawerComponents.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class PhotosScreen extends StatefulWidget {
  static String tag = '/PhotosScreen';

  const PhotosScreen({super.key});

  @override
  PhotosScreenState createState() => PhotosScreenState();
}

class PhotosScreenState extends State<PhotosScreen> {
  File? image;
  String error1 = 'No Error Detected';
  bool isIconShowingOrNot = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  Widget buildImageWidget() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: image != null
          ? Image.file(
        image!,
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      )
          : Container(),
    );
  }

  Future<void> loadImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const DrawerComponents(),
        appBar: AppBar(
          bottom: TabBar(
            onTap: (val) {
              if (kDebugMode) {
                print(val);
              }
              val == 1 ? isIconShowingOrNot = true : isIconShowingOrNot = false;
              setState(() {});
            },
            tabs: const [
              Tab(text: "Photos"),
              Tab(text: "Albums"),
            ],
            labelStyle: boldTextStyle(color: black.withOpacity(0.5), size: 16),
            unselectedLabelColor: black.withOpacity(0.5),
            labelColor: Colors.black,
          ),
          title: Text('Photos', style: boldTextStyle(size: 20)),
          actions: isIconShowingOrNot
              ? []
              : [
            IconButton(
              icon: const Icon(Feather.check_square, size: 20),
              onPressed: () {},
            )
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              children: [Expanded(child: buildImageWidget())],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(CSOfflineImg, width: 150, height: 150),
                16.height,
                Text("No albums yet", style: boldTextStyle(size: 20)),
                16.height,
                Text(
                  "Add some of your photos to an album to see it here!",
                  textAlign: TextAlign.center,
                  style: primaryTextStyle(size: 16),
                ).paddingSymmetric(horizontal: 50),
                16.height,
                Container(
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(color: CSDarkBlueColor),
                  child: Text('Create new album', style: boldTextStyle(color: Colors.white, size: 16)).center(),
                )
              ],
            )
          ],
        ),
        floatingActionButton: isIconShowingOrNot
            ? null
            : FloatingActionButton(
          backgroundColor: CSDarkBlueColor,
          onPressed: loadImage,
          child: const Icon(Icons.add_photo_alternate_outlined, color: Colors.white),
        ),
      ),
    );
  }
}

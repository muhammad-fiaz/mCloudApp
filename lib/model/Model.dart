import 'package:mcloud/component/CommonFileComponents.dart';
import 'package:mcloud/screens/mCDashboardScreen.dart';
import 'package:mcloud/screens/mCOfflineScreen.dart';
import 'package:mcloud/screens/mCPhotosScreen.dart';
import 'package:mcloud/screens/mCSettingScreen.dart';
import 'package:mcloud/screens/mCUpgradeAccountScreen.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';


class DataModel {
  String fileUrl;
  String? fileName;
  bool? isFileSelect;
  bool isDownload;
  bool isStared;
  bool isFolder;
  bool isShared;

  DataModel({this.fileUrl = CSDefaultImg, this.fileName, this.isFileSelect = false, this.isDownload = false, this.isShared = false, this.isStared = false, this.isFolder = false});
}

List<DataModel> getmCloudData() {
  List<DataModel> dataModel = [];
  dataModel.add(DataModel(fileName: "Books", fileUrl: CSBookImg, isDownload: true));
  dataModel.add(DataModel(fileName: "Nog says bow bow", fileUrl: CSANGIFImg, isDownload: true));
  dataModel.add(DataModel(fileName: "mCloud file", fileUrl: CSmCloudLogo, isStared: true));
  dataModel.add(DataModel(fileName: "John", fileUrl: CSFolderIcon, isFolder: true));

  return dataModel;
}

class DrawerModel {
  String? title;
  IconData? icon;
  Widget? goto;
  bool isSelected;

  DrawerModel({this.title, this.icon, this.goto, this.isSelected = false});
}

List<DrawerModel> getCSDrawer() {
  List<DrawerModel> drawerModel = [];
  drawerModel.add(DrawerModel(title: "Home", icon: Icons.home, goto: const DashboardScreen()));
  drawerModel.add(DrawerModel(title: "Files", icon: Icons.folder, goto: const CommonFileComponents(appBarTitle: AppName)));
  drawerModel.add(DrawerModel(title: "Photos", icon: Icons.photo, goto: const PhotosScreen()));
  drawerModel.add(DrawerModel(title: "Offline", icon: Icons.offline_bolt, goto: const OfflineScreen()));
  //_drawerModel.add(DrawerModel(title: "Notification", icon: Icons.notifications,goto: SizedBox()));
  drawerModel.add(DrawerModel(title: "Upgrade Account", icon: Icons.upgrade, goto: const UpgradeAccountScreen()));
  drawerModel.add(DrawerModel(title: "Setting", icon: Icons.settings, goto: const SettingScreen()));

  return drawerModel;
}

import 'package:mcloud/component/FileAndFolderEditingComponents.dart';
import 'package:mcloud/model/Model.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CSSearchBar extends SearchDelegate {
  final String? hintText;
  final List<DataModel>? listData;

  CSSearchBar({this.hintText, this.listData}) : super(textInputAction: TextInputAction.search, keyboardType: TextInputType.text);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [query.isEmpty ? 0.width : IconButton(icon: const Icon(Icons.clear), color: Colors.black, onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation, color: Colors.black),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // throw UnimplementedError();
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final resultList = query.isEmpty ? [] : listData!.where((element) => element.fileName!.toLowerCase().contains(query.toLowerCase())).toList();
    return resultList.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
              onTap: () {},
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              title: Text(resultList[index].fileName),
              leading: Image.asset(resultList[index].fileUrl, height: 30, width: 30),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () async {
                  await showBottomSheetForFileAndFolderEditingOption(context, resultList[index]);
                },
              ),
              subtitle: const Text(AppName),
            );
          },
          itemCount: resultList.length,
        )
        : noSearchOutput();
  }

  Widget noSearchOutput() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              CSSearchImg,
              height: 120,
              width: 120,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text("Searching in $AppName")
          ],
        ),
      ),
    );
  }
}

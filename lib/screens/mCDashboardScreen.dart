import 'package:mcloud/component/DrawerComponents.dart';
import 'package:mcloud/component/SearchBar.dart';
import 'package:mcloud/main.dart';
import 'package:mcloud/screens/mCRecentScreen.dart';
import 'package:mcloud/screens/mCSharedScreen.dart';
import 'package:mcloud/screens/mCStarredScreen.dart';
import 'package:mcloud/utils/Colors.dart';
import 'package:mcloud/utils/Constants.dart';
import 'package:mcloud/utils/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
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
      drawer: const DrawerComponents(),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CSSearchBar(hintText: "Searching in $AppName", listData: getmCloudList),
                      );
                    },
                  )
                ],
                expandedHeight: 120,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text("Home", style: boldTextStyle(size: 20)),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: primaryTextStyle(size: 18),
                    isScrollable: true,
                    tabs: const [
                      Tab(text: "Recent"),
                      Tab(text: "Shared"),
                      Tab(text: "Starred"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: const TabBarView(
            children: [
              RecentScreen(),
              SharedScreen(),
              StarredScreen(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showBottomSheetForAddingData(context);
          setState(() {});
        },
        backgroundColor: CSDarkBlueColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      width: double.infinity,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

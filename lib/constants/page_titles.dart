import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

typedef IndexSidebarBuilder = SidebarXItem Function(
    BuildContext context, int index);

class PageTitle {
  static const List<IconData> icons = [
    Icons.home,
//     Icons.person,
//     Icons.settings,
    Icons.logout,
  ];

  static const List<String> titles = [
    'Dashboard',
//     'Profile',
//     'Settings',
    'Logout',
  ];

  static String getTitleByIndex(int index) {
    return titles[index];
  }

  static List<SidebarXItem> sidebarItemBuilder(
    BuildContext context,
    int itemCount,
    IndexSidebarBuilder builder,
  ) {
    final List<SidebarXItem> sidebarItems = [];
    for (var i = 0; i < itemCount; i++) {
      sidebarItems.add(builder(context, i));
    }
    return sidebarItems;
  }
}

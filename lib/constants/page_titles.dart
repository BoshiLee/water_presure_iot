import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class PageTitle {
  static const List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.logout,
  ];

  static const List<String> titles = [
    'Dashboard',
    'Profile',
    'Settings',
    'Logout',
  ];

  static String getTitleByIndex(int index) {
    return titles[index];
  }

  static SidebarXItem getSidebarItem(int index, VoidCallback callback) =>
      SidebarXItem(
        icon: PageTitle.icons[index],
        label: PageTitle.getTitleByIndex(index),
        onTap: callback,
      );

  static List<SidebarXItem> getSidebarItems(VoidCallback callback) {
    final List<SidebarXItem> sidebarItems = [];
    for (var i = 0; i < titles.length; i++) {
      sidebarItems.add(getSidebarItem(i, callback));
    }
    return sidebarItems;
  }
}

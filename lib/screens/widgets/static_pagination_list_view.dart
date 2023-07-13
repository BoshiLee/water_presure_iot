import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StaticPaginationListView extends StatelessWidget {
  final Widget? header;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final RefreshCallback? onRefresh;
  final bool isLoading;
  final Widget? loadingWidget;
  final Widget? emptyPlaceHolder;
  final int itemCount;
  final bool hasRemain;
  final bool shrinkWrap;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final bool keepState;
  final double? cacheExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  StaticPaginationListView({
    this.header,
    this.controller,
    this.padding,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.onRefresh,
    this.hasRemain = false,
    this.isLoading = false,
    this.shrinkWrap = true,
    this.emptyPlaceHolder,
    this.loadingWidget,
    this.cacheExtent,
    required this.itemCount,
    required this.itemBuilder,
    this.keepState = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  bool get isEmpty => this.itemCount == 0;

  bool get isFirstLoading => this.isLoading && this.isEmpty;

  int get _itemCount {
    if (this.isFirstLoading) return 1;
    if (this.header != null) {
      return this.hasRemain ? this.itemCount + 2 : this.itemCount + 1;
    }
    if (this.hasRemain) {
      return itemCount + 1;
    }
    if (this.itemCount == 0) return 1;
    return this.itemCount;
  }

  ListView get listView {
    return ListView.builder(
      key: keepState
          ? null
          : ValueKey<int>(
              Random(
                DateTime.now().millisecondsSinceEpoch,
              ).nextInt(
                4294967296,
              ),
            ),
      keyboardDismissBehavior: this.keyboardDismissBehavior,
      padding: this.padding,
      controller: this.controller,
      shrinkWrap: this.shrinkWrap,
      cacheExtent: this.cacheExtent,
      physics: this.physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: this.scrollDirection,
      itemCount: this._itemCount,
      itemBuilder: (context, index) {
        if (this.isFirstLoading) {
          return this.loadingWidget ??
              Center(
                child: Text(
                  '讀取中',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
        }
        if (this.isEmpty) {
          return this.emptyPlaceHolder ??
              const Text(
                '目前沒有更多資料。',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              );
        }
        if (index == 0 && this.header != null) {
          return this.header!;
        }
        // 尾端讀取
        if (index == this._itemCount - 1 && hasRemain) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.redAccent[100],
                size: 30,
              ),
            ),
          );
        }
        return this.itemBuilder(
          context,
          this.header != null ? index - 1 : index,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.onRefresh != null)
      return RefreshIndicator(child: this.listView, onRefresh: this.onRefresh!);
    return this.listView;
  }
}

import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.iconData = Icons.add,
    this.index = 0,
    this.title = '',
    this.animationController,
  });

  IconData iconData;
  int index;
  String title;

  /// icon 动画
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: Icons.water_damage_outlined,
      index: 0,
      title: '首页',
      animationController: null,
    ),
    // 商城
    TabIconData(
      iconData: Icons.wallet_giftcard,
      index: 1,
      title: '商城',
      animationController: null,
    ),
    // 滚球
    TabIconData(
      iconData: Icons.sports_basketball,
      index: 2,
      title: '篮球',
      animationController: null,
    ),
    // 更多
    TabIconData(
      iconData: Icons.favorite,
      index: 3,
      title: '收藏',
      animationController: null,
    ),
    // 个人中心
    TabIconData(
      iconData: Icons.person,
      index: 4,
      title: '我的',
      animationController: null,
    ),
  ];
}

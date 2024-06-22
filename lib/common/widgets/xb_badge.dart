/// xb_badge.dart
/// author: Huxiaoyou
/// description: 带角标的组件


import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class XbBadge extends StatelessWidget {
  const XbBadge({
    Key? key,
    this.showBadge = true,
    this.child,
    this.padding = const EdgeInsets.all(4.0),
    this.topValue = -4,
    this.endValue = -4,
    this.badgeContent,
    this.toAnimate = true,
    this.badgeColor = Colors.red,
  }) : super(key: key);

  final bool showBadge;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final double topValue;
  final double endValue;
  final Widget? badgeContent;
  final bool toAnimate;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return badges.Badge(
      showBadge: showBadge,
      badgeStyle: badges.BadgeStyle(
        padding: padding,
        badgeColor: badgeColor,
      ),
      position: badges.BadgePosition.topEnd(top: topValue, end: endValue),
      badgeAnimation: badges.BadgeAnimation.slide(toAnimate: toAnimate),
      badgeContent: badgeContent,
      child: child,
    );
  }
}

/// xb_tabbar.dart
/// author: Huxiaoyou
/// description:  底部导航栏

import 'package:flutter/material.dart';
import 'package:flutter_demo01/configs/colors.dart';
import 'package:flutter_demo01/provider/theme_provider.dart';
import 'package:flutter_demo01/widgets/tabbar/tabIcon_data.dart';
import 'package:flutter_demo01/widgets/tabbar/tab_icons.dart';
import 'package:provider/provider.dart';

class XbBottomAppBar extends StatefulWidget {
  const XbBottomAppBar({
    Key? key,
    this.selectedPosition = 0,
    required this.selectedCallback,
    required this.iconList,
  }) : super(key: key);

  /// 选中下标
  final int selectedPosition;
  final Function(int selectedPosition) selectedCallback;
  final List<TabIconData> iconList;

  @override
  _XbBottomAppBarState createState() => _XbBottomAppBarState();
}

class _XbBottomAppBarState extends State<XbBottomAppBar>
    with TickerProviderStateMixin {
  /// BottomNavigationBar高度
  double barHeight = 56.0;

  /// 指示器高度
  // double indicatorHeight = 44.0;
  double indicatorSize = 38.0;

  /// 指示器 距离顶部高度
  double indicatorMarginTop = 2.0;

  /// 选中下标
  int selectedPosition = 0;

  /// 记录上一次的选中下标
  int previousSelectedPosition = 0;

  /// 选中图标高度
  // double selectedIconHeight = 28.0;

  /// 默认图标高度
  double normalIconSize = 26.0;

  double itemWidth = 0;

  late AnimationController controller;
  late Animation<double> animation;

  final myCurve = Cubic(0.68, 0, 0, 1.6);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        itemWidth = context.size!.width / widget.iconList.length;
      });
    });

    /// 设置动画时长
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    selectedPosition = widget.selectedPosition;
    previousSelectedPosition = widget.selectedPosition;
    animation = Tween(
            begin: selectedPosition.toDouble(),
            end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: myCurve));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    // 通过ThemeProvider进行主题管理
    final provider = Provider.of<ThemeProvider>(context);
    var bgColor = KColors.dynamicColor(
        context, KColors.kTabBarBgColor, KColors.kTabBarBgDarkColor);
    var selectTextColor = KColors.dynamicColor(
        context, provider.getThemeColor(), KColors.kThemeColor);

    /// 背景
    final background = Container(
      height: barHeight + MediaQuery.of(context).padding.bottom,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: const Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.0),
        ],
      ),
    );

    children.add(background);

    if (itemWidth == 0) {
      return Stack(clipBehavior: Clip.none, children: children);
    }

    /// 指示器
    children.add(
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Positioned(
            left: (itemWidth - indicatorSize) / 2 + animation.value * itemWidth,
            top: indicatorMarginTop,
            child: child!,
          );
        },
        child: Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectTextColor,
          ),
        ),
      ),
    );

    for (var i = 0; i < widget.iconList.length; i++) {
      /// 图标中心点计算
      final rectBg = Rect.fromCenter(
        center: Offset(itemWidth / 2 + (i * itemWidth), barHeight / 2),
        // width: itemWidth - 2,
        width: itemWidth,
        height: barHeight,
      );

      final iconMarginTop =
          indicatorMarginTop + (indicatorSize - normalIconSize) / 2;

      /// 每个Icon 格子  && title

      children.add(TabIcons(
        tabIconData: widget.iconList[i],
        rect: rectBg,
        isChecked: selectedPosition == i,
        normalIconSize: normalIconSize,
        iconMarginTop: iconMarginTop,
        removeAllSelect: () => _selectedPosition(i),
      ));
    }

    return Stack(clipBehavior: Clip.none, children: children);
  }

  void _selectedPosition(int position) {
    /// 去除重复点击
    if (position == selectedPosition) return;

    previousSelectedPosition = selectedPosition;
    selectedPosition = position;

    /// 执行动画
    animation = Tween(
            begin: previousSelectedPosition.toDouble(),
            end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: myCurve));

    controller.forward(from: 0.0);

    widget.selectedCallback(selectedPosition);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

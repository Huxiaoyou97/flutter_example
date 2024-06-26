import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_demo01/common/widgets/base_refresh_view.dart';
import 'package:flutter_demo01/common/widgets/xb_badge.dart';
import 'package:flutter_demo01/pages/tabbar/home_page.dart';
import 'package:flutter_demo01/pages/tabbar/news_page.dart';
import 'package:flutter_demo01/pages/tabbar/profile_page.dart';
import 'package:flutter_demo01/pages/tabbar/vip_page.dart';
import 'package:flutter_demo01/provider/tabbar_provider.dart';
import 'package:flutter_demo01/provider/theme_provider.dart';
import 'package:flutter_demo01/widgets/tabbar/tabIcon_data.dart';
import 'package:flutter_demo01/widgets/tabbar/xb_tabbar.dart';
import 'package:provider/provider.dart';

import 'common/utils/xb_image_utils.dart';
import 'common/widgets/xb_pulse_animation_view.dart';
import 'configs/colors.dart';


const double _iconWH = 24.0;
const double _fontSize = 10.0;

class BaseTabBar extends StatefulWidget {
  const BaseTabBar({Key? key}) : super(key: key);

  @override
  State<BaseTabBar> createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> {
  // int _currentIndex = 0;
  final List<Widget> _pageList = const [HomePage(), NewsPage(), VipPage(), ProfilePage()];

  final PageController _pageController = PageController();

  /// 图标
  final List<TabIconData> iconList = TabIconData.tabIconsList;

  bool _isAnimating = true;
  String _currentText = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 设置EasyRefresh的默认样式
    initEasyRefresh();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    /// 保持页面状态的几种方式 https://blog.csdn.net/iotjin/article/details/126870716
    /// 如果需要在某个页面跳转返回到tabbar的指定页面，Provider create 添加到main.dart，否则写在BaseTabBar中
    /// 通过 PageView + AutomaticKeepAliveClientMixin 保持页面状态（进到哪个页面，哪个页面开始初始化）
    /// 在需要保持页面状态的子页面State中，继承AutomaticKeepAliveClientMixin并重写方法 wantKeepAlive => true
    /// 并且它们的[build]方法必须调用super.build(context);
    return ChangeNotifierProvider(
      create: (_) => TabbarProvider(),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          controller: _pageController,
          children: _pageList,
        ),
        bottomNavigationBar: Consumer<TabbarProvider>(builder: (_, provider, __) {
          return Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              // splashFactory: InkSplash.splashFactory,
            ),
            child: XbBottomAppBar(selectedCallback: (position) => onClickBottomBar(position, provider), iconList: iconList)
          );
        }),
      ),
    );
  }

  void onClickBottomBar(int index, TabbarProvider tabbarProvider) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');
    setState(() {
      tabbarProvider.currentIndex = index;
      _pageController.jumpToPage(index);
      // 动画相关
      // _isAnimating = true;
    });
  }


  _createItem(String label, String imgPath, iconColor, {bool showBadge = false}) {
    var item = BottomNavigationBarItem(
      label: label,
      icon: !showBadge ? XbAssetImage(imgPath, width: _iconWH) : _addBadge(XbAssetImage(imgPath, width: _iconWH)),
      activeIcon: _addAnimation(label, XbAssetImage('${imgPath}_on', width: _iconWH, color: iconColor)),
    );
    return item;
  }

  _addBadge(child) {
    return XbBadge(
      padding: const EdgeInsets.all(4),
      child: child,
    );
  }

  _addAnimation(label, child) {
    if (_currentText != label) {
      return child;
    }
    if (label == '微信') {
      return Swing(child: child); // 摆动
    }
    if (label == '发现') {
      return Spin(child: child); // 旋转
    }
    // 跳动
    return XbPulseAnimationView(
      child: child,
      isAnimating: _isAnimating,
      onCompleted: () {
        setState(() {
          // 动画完成改变状态
          _isAnimating = false;
        });
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';

final List titleData = [
  'toast',
  '网络请求',
  '主题设置',
  'Socket',
  'BaseListView',
  'BaseGridView',
  'BaseGridView - 骨架屏',
  'BaseListView - 骨架屏',
  'BaseRefreshView - header/footer固定',
  'BaseRefreshView - header/footer跟随',
];

final List routeData = [
  'ToastTestPage',
  'HttpTestPage',
  'ThemeTestPage',
  'SocketTestPage',
  'BaseRefreshViewTestPage',
  'BaseRefreshViewTestPage',
  'BaseGridViewShimmerTestPage',
  'BaseListViewShimmerTestPage',
  'BaseRefreshViewHeaderFixedPage',
  'BaseRefreshViewHeaderFollowPage',
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('首页', leftWidget: Container()),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (index == 4 || index == 5) {
            /// 页面参数传递的例子
            var jumpParams = {'isGridView': index == 5 ? true : false};
            XbNavUtils.pushNamed(context, routeData[index],
                arguments: jumpParams);
          } else {
            XbNavUtils.pushNamed(context, routeData[index]);
          }
        },
      ),
    );
  }
}

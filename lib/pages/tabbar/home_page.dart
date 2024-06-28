import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';

final List titleData = [
  '网络请求',
  '主题设置',
  '多语言设置',
  'Socket',
  'BaseListView',
  'BaseGridView',
  'BaseGridView - 骨架屏',
  'BaseListView - 骨架屏',
  'BaseRefreshView - header/footer固定',
  'BaseRefreshView - header/footer跟随',
  '底部弹框',
  '中间弹框',
  'Toast',
  'Dialog',
  '级联选择器（多维数组结构数据）',
  '级联选择器（树形结构数据、支持搜索）',
  'GridViewTest1',
  'GridViewTest2',
  'GridViewTest3',
  'GridViewTest4',
  'GridViewTest5',
  'ListViewTest1',
  'ListViewTest2',
  'ListViewTest3',
  'ListViewTest4',
  'ListViewTest5',
  'ListViewTestCard',
  'ListViewTestCustomVC',
  '路由相关',
  '功能组件',
  '列表侧滑',
  '权限相关',
  'WebView百度',
];

final List routeData = [
  'HttpTestPage',
  'ThemeTestPage',
  'LocalePage',
  'SocketTestPage',
  'BaseRefreshViewTestPage',
  'BaseRefreshViewTestPage',
  'BaseGridViewShimmerTestPage',
  'BaseListViewShimmerTestPage',
  'BaseRefreshViewHeaderFixedPage',
  'BaseRefreshViewHeaderFollowPage',
  'BottomSheetTest',
  'AlertTestPage',
  'ToastTestPage',
  'DialogTestPage',
  'CascadePickerTest',
  'CascadeTreePickerTest',
  'GridViewTest1',
  'GridViewTest2',
  'GridViewTest3',
  'GridViewTest4',
  'GridViewTest5',
  'ListViewTest1',
  'ListViewTest2',
  'ListViewTest3',
  'ListViewTest4',
  'ListViewTest5',
  'ListViewTestCard',
  'ListViewTestCustomVC',
  'RouteDemoListPage',
  'ComponentDemoListPage',
  'SideslipTestPage',
  'PermissionTestPage',
  'WebView',
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
          if (str == "WebView百度") {
            XbNavUtils.jumpWebViewPage(context, '百度', 'https://www.baidu.com');

            return;
          }

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

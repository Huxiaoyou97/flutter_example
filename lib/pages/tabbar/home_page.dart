import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';

final List titleData = [
  '网络请求',
  '主题设置',
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
];

final List routeData = [
  'HttpTestPage',
  'ThemeTestPage',
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
          if (index == 3 || index == 4) {
            /// 页面参数传递的例子
            var jumpParams = {'isGridView': index == 4 ? true : false};
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

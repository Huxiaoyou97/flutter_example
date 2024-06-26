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
  'BaseGridView - 骨架屏',
];

final List routeData = [
  'ToastTestPage',
  'HttpTestPage',
  'ThemeTestPage',
  'SocketTestPage',
  'BaseGridViewShimmerTestPage',
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
          XbNavUtils.pushNamed(context, routeData[index]);
        },
      ),
    );
  }
}

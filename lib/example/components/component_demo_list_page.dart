import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';

final List titleData = [
  '水平滑动菜单',
  'Tags标签',
  '折叠面板',
];
final List routeData = [
  'SlideMenuTestPage',
  'TagViewTestPage',
  'CollapseViewTestPage',
];

class ComponentDemoListPage extends StatelessWidget {
  const ComponentDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('功能组件'),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          XbNavUtils.pushNamed(context, routeData[index]);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';

final List titleData = ['跳转传值与回传、多级返回', '监听页面出现与消失', '禁用手势返回和安卓返回键'];
final List routeData = ['PassValuePage', 'RouteTestPage1', 'RouteTestPage2'];

class RouteDemoListPage extends StatelessWidget {
  const RouteDemoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('路由相关'),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (str == '禁用手势返回和安卓返回键') {
            XbNavUtils.pushNamedResult(context, 'RouteTestPage2', {},
                (returnData) {
              if (returnData['isRefresh'] == true) {
                _requestData();
              }
            });
          } else {
            XbNavUtils.pushNamed(context, routeData[index]);
          }
        },
      ),
    );
  }

  void _requestData() {
    XbProgressHUD.showLoadingText();
    Future.delayed(const Duration(seconds: 1), () {
      XbProgressHUD.hide();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/utils/xb_nav_router_utils.dart';
import 'package:flutter_demo01/common/utils/xb_toast.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_scrollview.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';
import '/base_appbar.dart';
import 'pass_value_page2.dart';

class PassValuePage extends StatelessWidget {
  const PassValuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('传值'),
      body: _body(context),
    );
  }

  _body(context) {
    var params = {
      'passValue': '123',
      'isBool': true,
      'array': [1, 2, 3],
    };

    return XbScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('以下是XbNavUtils方式(基于fluro路由封装) - 推荐'),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转带回传刷新 - pushNamedResult'),
              onPressed: () {
                params['type'] = '1';

                XbNavUtils.pushNamedResult(context, 'PassValuePage2', params,
                    (returnData) {
                  print('回传的值====$returnData');
                  if (returnData['isRefresh'] == true) {
                    _requestData();
                  }
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转带回传 - pushNamedResult'),
              onPressed: () {
                params['type'] = '2';

                XbNavUtils.pushNamedResult(context, 'PassValuePage2', params,
                    (returnData) {
                  print('回传的值====$returnData');
                  XbToast.showText(context,
                      msg: '返回的参数: ${returnData.toString()}');
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转 - pushNamed'),
              onPressed: () {
                params['type'] = '3';

                XbNavUtils.pushNamed(context, 'PassValuePage2',
                    arguments: params);
              },
            ),
            const SizedBox(height: 10),
            const Text('以下是flutter原生方式'),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转带回传 - Navigator.push'),
              onPressed: () {
                params['type'] = '4';

                // 普通路由跳转传值带回传
                // Navigator.push(context, MaterialPageRoute(builder: (context) => (PassValuePage2(params))))
                //     .then((returnData) {
                //   print('回传的值====$returnData');
                //   XbToast.showText(context, msg: '返回的参数: ${returnData.toString()}');
                // });

                // 效果同上，基于Navigator封装
                XbNavRouterUtils.pushNamedResult(
                    context, PassValuePage2(params), (returnData) {
                  print('回传的值====$returnData');
                  XbToast.showText(context,
                      msg: '返回的参数: ${returnData.toString()}');
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转 - Navigator.push'),
              onPressed: () {
                params['type'] = '5';

                // 普通路由跳转传值，以下三种效果一样
                // Navigator.push(context, MaterialPageRoute(builder: (context) => (PassValuePage2(params)))); // 普通路由
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (PassValuePage2(params)))); // 普通路由

                // 效果同上，基于Navigator封装
                XbNavRouterUtils.push(context, PassValuePage2(params));
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转(渐隐转场动画) - Navigator.push'),
              onPressed: () {
                params['type'] = '6';

                // 渐隐转场动画
                Navigator.of(context)
                    .push(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        //动画时间为500毫秒
                        pageBuilder: (context, animation1, animation2) {
                          return FadeTransition(
                            opacity: animation1,
                            child: PassValuePage2(params),
                          );
                        }))
                    .then((returnData) {
                  print('回传的值====$returnData');
                  XbToast.showText(context,
                      msg: '返回的参数: ${returnData.toString()}');
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('带参数跳转带回传 - Navigator.pushNamed'),
              onPressed: () {
                params['type'] = '7';

                // 命名路由跳转传值带回传
                Navigator.pushNamed(context, 'PassValuePage3',
                        arguments: params)
                    .then((returnData) {
                  print('回传的值====$returnData');
                  XbToast.showText(context,
                      msg: '返回的参数: ${returnData.toString()}');
                });
              },
            ),
          ]),
    );
  }

  void _requestData() {
    XbProgressHUD.showLoadingText();
    Future.delayed(const Duration(seconds: 1), () {
      XbProgressHUD.hide();
    });
  }
}

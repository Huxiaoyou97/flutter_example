import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_alert.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';

final List titleData = [
  'XbAlert-中间-标题',
  'XbAlert-中间-标题+内容',
  'XbAlert-底部-带标题内容',
  'XbAlert-底部-带标题内容红色按钮',
  'XbAlert-底部-只有标题红色按钮',
  'XbAlert-底部-只有红色按钮',
  'XbAlert-底部-标题常规按钮'
];

class AlertTestPage extends StatelessWidget {
  const AlertTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("AlertDemoList"),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (str == 'XbAlert-中间-标题') {
            XbAlert.showAlert(context, title: '提示',
                clickCallback: (index, text) {
              if (index == 1) {
                print('点击右侧按钮');
              }
            });
          }
          if (str == 'XbAlert-中间-标题+内容') {
            XbAlert.showAlert(context,
                title: '提示',
                content: '这是内容这是内容这是内容',
                leftText: '左侧',
                rightText: '右侧', clickCallback: (index, text) {
              if (index == 0) {
                print('点击左侧按钮');
                XbProgressHUD.showText('点击左侧按钮');
              }
              if (index == 1) {
                print('点击右侧按钮');
                XbProgressHUD.showText('点击右侧按钮');
              }
            });
          }
          if (str == 'XbAlert-底部-带标题内容') {
            XbAlert.showActionSheet(context,
                title: '提示',
                content: '这是提示内容这是提示内容这是提示内容这是提示内容',
                otherBtnTitles: ['一', '二'], clickCallback: (index, text) {
              print(index);
              XbProgressHUD.showText(text);
            });
          }
          if (str == 'XbAlert-底部-带标题内容红色按钮') {
            XbAlert.showActionSheet(context,
                title: '这是提示',
                content: '这是提示内容这是提示内容这是提示内容这是提示内容',
                otherBtnTitles: ['一', '二'],
                redBtnTitle: '删除', clickCallback: (index, text) {
              print(index);
              print(text);
              XbProgressHUD.showText(text);
            });
          }
          if (str == 'XbAlert-底部-只有标题红色按钮') {
            XbAlert.showActionSheet(context,
                title: '这是提示',
                otherBtnTitles: ['一'],
                redBtnTitle: '删除', clickCallback: (index, text) {
              print(index);
              print(text);
              XbProgressHUD.showText(text);
            });
          }
          if (str == 'XbAlert-底部-只有红色按钮') {
            XbAlert.showActionSheet(context,
                otherBtnTitles: ['一'],
                redBtnTitle: '删除', clickCallback: (index, text) {
              print(index);
              print(text);
              XbProgressHUD.showText(text);
            });
          }
          if (str == 'XbAlert-底部-标题常规按钮') {
            XbAlert.showActionSheet(context,
                title: '请选择',
                otherBtnTitles: ['一', '二'], clickCallback: (index, text) {
              print(index);
              print(text);
              XbProgressHUD.showText(text);
            });
          }
        },
      ),
    );
  }
}

/// 登录进度提示框  loading 状态
showLoading(BuildContext context, [String? text]) {
  text = text ?? '加载中...';
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 120, minWidth: 180),
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: const [
                // 阴影
                BoxShadow(
                  color: Colors.black12,
                  //offset: Offset(2.0,2.0),
                  blurRadius: 10.0,
                )
              ]),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  strokeWidth: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  text!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

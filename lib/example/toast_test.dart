import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/utils/xb_toast.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';

import '../base_appbar.dart';

final List titleData = [
  '文字',
  '成功',
  '失败',
  '警告',
  '加载中',
  '水平加载中',
  '自定义图文',
  '水平自定义图文',
  'iOS样式加载中'
];

class ToastTestPage extends StatelessWidget {
  const ToastTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('弹窗例子'),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (index == 0) {
            XbToast.showText(
              context, msg: '这是一条提示文字信息',
              //              closeTime: 10
            );
          }
          if (index == 1) {
            XbToast.showSuccess(context, msg: '加载成功');
          }
          if (index == 2) {
            XbToast.showError(context, msg: '上传失败。请重新上传数据');
          }
          if (index == 3) {
            XbToast.showInfo(context, msg: '注意！注意！注意！');
          }
          if (index == 4) {
            var hide = XbToast.showLoadingText(context, msg: '正在加载中...');
            Future.delayed(const Duration(seconds: 2), () {
              hide();
            });
          }

          if (index == 5) {
            var hide =
                XbToast.showHorizontalLoadingText(context, msg: '正在加载中...');
            Future.delayed(const Duration(seconds: 2), () {
              hide();
            });
          }
          if (index == 6) {
            Widget img = Image.asset(
              'assets/images/toast_error.png',
              package: 'Xbtoast',
            );
            XbToast.showImageText(context, msg: '自定义图文', image: img);
          }

          if (index == 7) {
            Widget img = Image.asset('assets/images/toast_success.png',
                package: 'Xbtoast');
            XbToast.showHorizontalImageText(context,
                msg: '水平自定义图文', image: img);
          }

          if (index == 8) {
            var hide = XbToast.showIOSLoadingText(
              context,
              msg: '正在加载中...',
            );
            Future.delayed(const Duration(seconds: 2), () {
              hide();
            });
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/utils/xb_permission_utils.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';

final List titleData = [
  'XbPermissionUtils-photos',
  'XbPermissionUtils-camera',
  'XbPermissionUtils-microphone',
  'XbPermissionUtils-storage',
];

class PermissionTestPage extends StatelessWidget {
  const PermissionTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('权限获取'),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (str == 'XbPermissionUtils-photos') {
            _photosPermission();
          }
          if (str == 'XbPermissionUtils-camera') {
            _cameraPermission();
          }
          if (str == 'XbPermissionUtils-microphone') {
            _microphonePermission();
          }
          if (str == 'XbPermissionUtils-storage') {
            _storagePermission();
          }
        },
      ),
    );
  }

  _photosPermission() async {
    bool isGranted = await XbPermissionUtils.photos();
    if (!isGranted) {
      return;
    }
    XbProgressHUD.showText('已授权photos权限');
  }

  _cameraPermission() async {
    bool isGranted = await XbPermissionUtils.camera();
    if (!isGranted) {
      return;
    }
    XbProgressHUD.showText('已授权camera权限');
  }

  _microphonePermission() async {
    bool isGranted = await XbPermissionUtils.microphone();
    if (!isGranted) {
      return;
    }
    XbProgressHUD.showText('已授权microphone权限');
  }

  _storagePermission() async {
    bool isGranted = await XbPermissionUtils.storage();
    if (!isGranted) {
      return;
    }
    XbProgressHUD.showText('已授权storage权限');
  }
}

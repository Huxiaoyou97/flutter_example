import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/utils/xb_toast.dart';
import 'package:flutter_demo01/http/apis.dart';

class HttpTestPage extends StatefulWidget {
  const HttpTestPage({super.key});

  @override
  State<HttpTestPage> createState() => _HttpTestPageState();
}

class _HttpTestPageState extends State<HttpTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar("网络请求示例"),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              ElevatedButton(
                onPressed: () {
                  getRequest(context);
                },
                child: const Text('GET请求'),
              ),
            ],
          ),
        ));
  }
}

/// 发送GET请求 获取图形验证码
void getRequest(BuildContext context) async {
  var url = APIS.apiPrefix + APIS.captcha;
  var dio = Dio();
  var response = await dio.get(url);
  var result = response.data.toString();
  print('返回数据： $result');
  if (response.data['code'] == 0) {
    XbToast.showSuccess(context, msg: '请求成功');
  } else {
    XbToast.showError(context, msg: '请求失败');
  }
}

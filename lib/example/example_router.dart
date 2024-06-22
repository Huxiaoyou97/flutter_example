// ignore_for_file: unused_import

import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo01/routes/router_init.dart';

/// toast
import 'package:flutter_demo01/example/toast_test.dart';

import 'http_test.dart';


class ExampleRouter implements IRouterProvider {
  @override
  void initRouter(FluroRouter router) {
    router.define('ToastTestPage', handler: Handler(handlerFunc: (_, __) => const ToastTestPage()));
    router.define('HttpTestPage', handler: Handler(handlerFunc: (_, __) => const HttpTestPage()));
  }
}

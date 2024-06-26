// ignore_for_file: unused_import

import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo01/example/base/base_gridview_shimmer_test_page.dart';
import 'package:flutter_demo01/example/socket_test.dart';
import 'package:flutter_demo01/example/theme_test.dart';
import 'package:flutter_demo01/routes/router_init.dart';

/// toast
import 'package:flutter_demo01/example/toast_test.dart';

import 'http_test.dart';


class ExampleRouter implements IRouterProvider {
  @override
  void initRouter(FluroRouter router) {
    router.define('ToastTestPage', handler: Handler(handlerFunc: (_, __) => const ToastTestPage()));
    router.define('HttpTestPage', handler: Handler(handlerFunc: (_, __) => const HttpTestPage()));
    router.define('ThemeTestPage', handler: Handler(handlerFunc: (_, __) => const ThemeTestPage()));
    router.define('SocketTestPage', handler: Handler(handlerFunc: (_, __) => const SocketTestPage()));

    // base
    router.define('BaseGridViewShimmerTestPage', handler: Handler(handlerFunc: (_, __) => const BaseGridViewShimmerTestPage()));
  }
}

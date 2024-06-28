// ignore_for_file: unused_import

import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo01/example/alert/alert_test.dart';
import 'package:flutter_demo01/example/alert/bottom_sheet_test.dart';
import 'package:flutter_demo01/example/alert/cascade_picker_test.dart';
import 'package:flutter_demo01/example/alert/cascade_tree_picker_test.dart';
import 'package:flutter_demo01/example/alert/dialog_test_page.dart';
import 'package:flutter_demo01/example/base/base_gridview_shimmer_test_page.dart';
import 'package:flutter_demo01/example/base/base_listview_shimmer_test_page.dart';
import 'package:flutter_demo01/example/base/base_refresh_view_header_fixed_page.dart';
import 'package:flutter_demo01/example/base/base_refresh_view_header_follow_page.dart';
import 'package:flutter_demo01/example/base/base_refresh_view_test_page.dart';
import 'package:flutter_demo01/example/gridView/gridview_test1.dart';
import 'package:flutter_demo01/example/gridView/gridview_test2.dart';
import 'package:flutter_demo01/example/gridView/gridview_test3.dart';
import 'package:flutter_demo01/example/gridView/gridview_test4.dart';
import 'package:flutter_demo01/example/gridView/gridview_test5.dart';
import 'package:flutter_demo01/example/listView/listview_test.dart';
import 'package:flutter_demo01/example/listView/listview_test2.dart';
import 'package:flutter_demo01/example/listView/listview_test3.dart';
import 'package:flutter_demo01/example/listView/listview_test4.dart';
import 'package:flutter_demo01/example/listView/listview_test5.dart';
import 'package:flutter_demo01/example/listView/listview_test_card.dart';
import 'package:flutter_demo01/example/listView/listview_test_custom_vc.dart';
import 'package:flutter_demo01/example/socket_test.dart';
import 'package:flutter_demo01/example/theme_test.dart';
import 'package:flutter_demo01/routes/router_init.dart';

/// toast
import 'package:flutter_demo01/example/toast_test.dart';

import 'http_test.dart';


class ExampleRouter implements IRouterProvider {
  @override
  void initRouter(FluroRouter router) {
    router.define('HttpTestPage', handler: Handler(handlerFunc: (_, __) => const HttpTestPage()));
    router.define('ThemeTestPage', handler: Handler(handlerFunc: (_, __) => const ThemeTestPage()));
    router.define('SocketTestPage', handler: Handler(handlerFunc: (_, __) => const SocketTestPage()));

    // base
    router.define('BaseRefreshViewTestPage', handler: Handler(handlerFunc: (_, params) {
      var jumpParams = params['jumpParams']!.first;
      return BaseRefreshViewTestPage(jsonDecode(jumpParams));
    }));
    router.define('BaseListViewShimmerTestPage', handler: Handler(handlerFunc: (_, __) => const BaseListViewShimmerTestPage()));
    router.define('BaseGridViewShimmerTestPage', handler: Handler(handlerFunc: (_, __) => const BaseGridViewShimmerTestPage()));
    router.define('BaseRefreshViewHeaderFixedPage', handler: Handler(handlerFunc: (_, __) => const BaseRefreshViewHeaderFixedPage()));
    router.define('BaseRefreshViewHeaderFollowPage', handler: Handler(handlerFunc: (_, __) => const BaseRefreshViewHeaderFollowPage()));

    // Alert
    router.define('BottomSheetTest', handler: Handler(handlerFunc: (_, __) => const BottomSheetTest()));
    router.define('AlertTestPage', handler: Handler(handlerFunc: (_, __) => const AlertTestPage()));
    router.define('ToastTestPage', handler: Handler(handlerFunc: (_, __) => const ToastTestPage()));
    router.define('DialogTestPage', handler: Handler(handlerFunc: (_, __) => const DialogTestPage()));
    router.define('CascadePickerTest', handler: Handler(handlerFunc: (_, __) => const CascadePickerTest()));
    router.define('CascadeTreePickerTest', handler: Handler(handlerFunc: (_, __) => const CascadeTreePickerTest()));

    // GridView
    router.define('GridViewTest1', handler: Handler(handlerFunc: (_, __) => const GridViewTest1()));
    router.define('GridViewTest2', handler: Handler(handlerFunc: (_, __) => const GridViewTest2()));
    router.define('GridViewTest3', handler: Handler(handlerFunc: (_, __) => const GridViewTest3()));
    router.define('GridViewTest4', handler: Handler(handlerFunc: (_, __) => const GridViewTest4()));
    router.define('GridViewTest5', handler: Handler(handlerFunc: (_, __) => const GridViewTest5()));

    // ListView
    router.define('ListViewTest1', handler: Handler(handlerFunc: (_, __) => const ListViewTest()));
    router.define('ListViewTest2', handler: Handler(handlerFunc: (_, __) => const ListViewTest2()));
    router.define('ListViewTest3', handler: Handler(handlerFunc: (_, __) => const ListViewTest3()));
    router.define('ListViewTest4', handler: Handler(handlerFunc: (_, __) => const ListViewTest4()));
    router.define('ListViewTest5', handler: Handler(handlerFunc: (_, __) => const ListViewTest5()));
    router.define('ListViewTestCard', handler: Handler(handlerFunc: (_, __) => const ListViewTestCard()));
    router.define('ListViewTestCustomVC', handler: Handler(handlerFunc: (_, __) => const ListViewTestCustomVC()));

  }
}

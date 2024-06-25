/// socket_base_page.dart
/// author: Huxiaoyou
/// description: WebSocket基类页面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/socket_provider.dart';

mixin WebSocketMixin<T extends StatefulWidget> on State<T> {
  String get socketUrl;
  WebSocketProvider? _webSocketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _webSocketProvider = Provider.of<WebSocketProvider>(context);
    _webSocketProvider?.connect(socketUrl);
  }

  @override
  void dispose() {
    print("离开页面,断开连接");
    print("socket provider $_webSocketProvider");
    _webSocketProvider?.disconnect();
    super.dispose();
  }
}

abstract class WebSocketBasePage extends StatefulWidget {
  const WebSocketBasePage({Key? key}) : super(key: key);
}
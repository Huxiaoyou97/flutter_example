import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/provider/socket_provider.dart';
import 'package:flutter_demo01/widgets/socket_base_page.dart';
import 'package:provider/provider.dart';

class SocketTestPage extends WebSocketBasePage {
  const SocketTestPage({super.key});

  @override
  _SocketTestPageState createState() => _SocketTestPageState();
}

class _SocketTestPageState extends State<SocketTestPage> with WebSocketMixin {
  @override
  String get socketUrl => 'wss://xxxx.com'; // 替换为真实的WebSocket地址

  @override
  Widget build(BuildContext context) {
    final webSocketProvider = Provider.of<WebSocketProvider>(context);

    return Scaffold(
      appBar: BaseAppBar('WebSocket测试'),
      body: ListView.builder(
        itemCount: webSocketProvider.messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(webSocketProvider.messages[index]),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/utils/xb_socket_utils.dart';

class WebSocketProvider extends ChangeNotifier {
  XbSocketUtils? _socketUtils;
  List<String> _messages = [];

  List<String> get messages => _messages;

  void connect(String url) {
    _socketUtils = XbSocketUtils.getInstance(url: url);
    _socketUtils?.onMessage = _onMessage;
    _socketUtils?.connect();
  }

  void disconnect() {
    _socketUtils?.disconnect();
    _socketUtils = null;
  }

  void _onMessage(dynamic message) {
    _messages.add(message.toString());
    notifyListeners();
  }

  void sendMessage(String message) {
    _socketUtils?.send(message);
  }
}
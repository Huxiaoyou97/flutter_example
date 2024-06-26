import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

typedef OnMessageCallback = void Function(dynamic message);

/// WebSocket工具类
class XbSocketUtils {
  static XbSocketUtils? _instance;
  final String url;
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  bool _isReconnecting = false;
  final Duration heartbeatInterval;
  final Duration reconnectInterval;
  final int maxReconnectAttempts;
  int _reconnectAttempts = 0;
  OnMessageCallback? onMessage;
  bool _isDisconnecting = false;

  XbSocketUtils._internal({
    required this.url,
    this.heartbeatInterval = const Duration(seconds: 5),
    this.reconnectInterval = const Duration(seconds: 10),
    this.maxReconnectAttempts = 10,
  });

  static XbSocketUtils getInstance({
    required String url,
    Duration heartbeatInterval = const Duration(seconds: 5),
    Duration reconnectInterval = const Duration(seconds: 10),
    int maxReconnectAttempts = 10,
  }) {
    _instance ??= XbSocketUtils._internal(
      url: url,
      heartbeatInterval: heartbeatInterval,
      reconnectInterval: reconnectInterval,
      maxReconnectAttempts: maxReconnectAttempts,
    );
    return _instance!;
  }

  /// 连接WebSocket
  void connect() {
    if (_isConnected) {
      // 如果已经连接,就不需要重新连接
      return;
    }

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;

    _channel?.stream.listen(
      (message) {
        _reconnectAttempts = 0; // 重置重连次数
        _onMessage(message);
      },
      onDone: _onDone,
      onError: _onError,
    );

    _startHeartbeat();

    // 如果正在重连,取消重连定时器
    if (_isReconnecting) {
      _reconnectTimer?.cancel();
      _isReconnecting = false;
    }
  }

  /// 发送消息
  void send(String message) {
    if (_isConnected) {
      _channel?.sink.add(message);
    }
  }

  /// 处理收到的消息
  void _onMessage(dynamic message) {
    if (message == 'pong') {
      // 收到服务端的pong响应
      print('收到pong响应');
    } else {
      // 处理其他消息
      // print('收到消息: $message');
      onMessage?.call(message);
    }
  }

  /// 连接关闭时的处理
  void _onDone() {
    print("socket close done $_isDisconnecting");
    _isConnected = false;
    if (!_isDisconnecting) {
      _reconnect();
    }
  }

  /// 连接错误时的处理
  void _onError(error) {
    print("socket close error $error ---- $_isDisconnecting");
    _isConnected = false;
    if (!_isDisconnecting) {
      _reconnect();
    }
  }

  /// 开始发送心跳包
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();

    // 不是连接状态,不需要发送心跳包
    if (!_isConnected) return;
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
      print("触发 ping $_heartbeatTimer --- $_isConnected");
      if (_isConnected) {
        send('ping');
      }
    });
  }

  /// 断开连接
  void disconnect() {
    print("socket close $_heartbeatTimer");
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _isConnected = false;
    _isReconnecting = false;
    _isDisconnecting = true;
    print("socket disconnect $_isDisconnecting");
    _channel?.sink.close(status.normalClosure);
  }

  /// 尝试重连
  void _reconnect() {
    if (_isReconnecting) return;
    if (_reconnectAttempts >= maxReconnectAttempts) {
      // print("达到最大重连次数，不再尝试重连");
      _reconnectTimer?.cancel();
      _heartbeatTimer?.cancel();
      return;
    }
    _isReconnecting = true;
    _reconnectAttempts++;

    _reconnectTimer = Timer.periodic(reconnectInterval, (timer) {
      if (_isConnected) {
        _reconnectTimer?.cancel();
        _isReconnecting = false;
      } else {
        connect();
      }
    });
  }
}

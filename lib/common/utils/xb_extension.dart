/// xb_extension.dart
/// author: Huxiaoyou
/// description: 项目的一些全局配置项，数据持久化使用的key

import 'package:flutter/material.dart';

extension XbMediaQueryExtension on BuildContext {
  MediaQueryData get xbMediaQuery => MediaQuery.of(this);

  Size get xbSize => xbMediaQuery.size;

  double get xbScreenWidth => xbSize.width;

  double get xbScreenHeight => xbSize.height;

  double get xbScale => xbMediaQuery.devicePixelRatio;

  // double get xbTextScaleFactor => xbMediaQuery.textScaleFactor;

  double get xbNavigationBarHeight => xbMediaQuery.padding.top + kToolbarHeight;

  double get xbTopSafeHeight => xbMediaQuery.padding.top;

  double get xbBottomSafeHeight => xbMediaQuery.padding.bottom;
}

extension XbStringExtension on String? {
  /// String 空安全处理
  String get xbNullSafe => this ?? '';

  /// String类型转num类型，为空转成0
  num get xbToNum => num.tryParse(this ?? '') ?? 0;
}

extension XbNumExtension on num? {
  /// num 空安全处理
  String get xbNullSafe => this?.toString() ?? '';

  /// num类型转String类型整数
  String get xbToIntStr => (this ?? 0).toInt().toString();
}

extension XbIntExtension on int? {
  /// int 空安全处理
  String get xbNullSafe => this?.toString() ?? '';

  /// int类型转String类型整数
  String get xbToIntStr => (this ?? 0).toString();
}

extension XbNullListExtension<T> on List<T>? {
  /// List 空安全处理
  List<T> get xbNullSafe => this ?? [];

  bool get xbIsNullOrEmpty => this == null || this!.isEmpty;
}

extension XbNullMapExtension<K, V> on Map<K, V>? {
  /// Map 空安全处理
  Map<K, V> get xbNullSafe => this ?? {};

  bool get xbIsNullOrEmpty => this == null || this!.isEmpty;
}

extension XbNullBoolExtension on bool? {
  /// bool 空安全处理
  bool get xbNullSafe => this ?? false;
}

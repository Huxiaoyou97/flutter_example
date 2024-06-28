/// locale_utils.dart
/// author: Huxiaoyou
/// description: 国际化工具类

import 'dart:ui';
import 'package:flutter_demo01/common/utils/xb_storage_utils.dart';
import 'package:get/get.dart';

const String _appLocaleKey = 'AppLocale';
const Locale chineseLocale = Locale('zh', 'CN');
const Locale englishLocale = Locale('en', 'US');

class LocaleUtils {
  /// 获取系统语言
  // static Locale? get deviceLocale => Get.deviceLocale;
  static Locale? get deviceLocale => PlatformDispatcher.instance.locale;

  /// 当指定语言不存在时，使用的语言
  static const fallbackLocale = chineseLocale;

  /// 支持的语言列表
  static final supportedLocales = [
    chineseLocale,
    englishLocale,
  ];

  /// 获取当前语言
  static Locale? get currentLocale {
    final String localeMode = getLocaleMode();
    var locale = getLocaleList().firstWhere(
        (item) => item['localeMode'] == localeMode,
        orElse: () => null);
    if (locale != null) {
      return locale['value'];
    }
    return deviceLocale;
    // return const Locale('zh', 'CN');
    // return const Locale('en', 'US');
  }

  /// 设置语言
  static void setLocale(String localeMode) {
    XbAESStorageUtils.saveString(_appLocaleKey, localeMode);
    var locale = getLocaleList().firstWhere(
        (item) => item['localeMode'] == localeMode,
        orElse: () => null);
    if (locale != null) {
      // Get.updateLocale(Locale('zh', 'CN'));
      // Get.updateLocale(Locale('en', 'US'));
      Get.updateLocale(locale['value']);
    }
  }

  /// 获取语言列表
  static List getLocaleList() {
    return [
      {'label': '跟随系统', 'value': deviceLocale, 'localeMode': 'system'},
      {
        'label': '简体中文',
        'value': const Locale('zh', 'CN'),
        'localeMode': 'zhCN'
      },
      {
        'label': 'English',
        'value': const Locale('en', 'US'),
        'localeMode': 'enUS'
      },
      // 印度
      {
        'label': 'हिंदी',
        'value': const Locale('hi', 'IN'),
        'localeMode': 'hiIN'
      },
    ];
  }

  /// 获取当前语言类型
  static String getLocaleMode() {
    final String locale = XbAESStorageUtils.getString(_appLocaleKey) ?? '';
    return locale;
  }

  /// 当前语言是否是中文
  static bool get isChinese => currentLocale?.languageCode == chineseLocale;
}

/// intl_config.dart
/// author: Huxiaoyou
/// description:  国际化配置

import 'package:flutter_demo01/intl/intl_hi.dart';
import 'package:get/get.dart';
import 'intl_zh.dart';
import 'intl_en.dart';

class LangTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': intlZhCn,
        'en_US': intlEnUs,
        'hi_IN': intlHiIn,
      };
}

/// 国际化的key
// class IntlKeys {
//   // test
//   static const String test = 'test';
// }

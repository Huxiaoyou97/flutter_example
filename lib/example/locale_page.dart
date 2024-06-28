import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/configs/colors.dart';
import 'package:flutter_demo01/intl/locale_utils.dart';
import 'package:flutter_demo01/provider/theme_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LocalePage extends StatefulWidget {
  const LocalePage({super.key});

  @override
  State<LocalePage> createState() => _LocalePageState();
}

class _LocalePageState extends State<LocalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("测试".tr),
      body: _body(),
    );
  }

  Widget _body() {
    List dataArr = LocaleUtils.getLocaleList();
    // TODO: 通过ThemeProvider进行主题管理
    final themeProvider = Provider.of<ThemeProvider>(context);
    var themeColor = KColors.dynamicColor(
        context, themeProvider.getThemeColor(), KColors.kThemeColor);

    var localeMode = LocaleUtils.getLocaleMode();

    return ListView.separated(
      itemCount: dataArr.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, int index) {
        var item = dataArr[index];
        return InkWell(
          onTap: () {
            print('选中语言: ${item['label']}');
            setState(() {
              LocaleUtils.setLocale(item['localeMode']);
            });
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 50.0,
            child: Row(
              children: <Widget>[
                Expanded(child: Text(item['label'])),
                Opacity(
                  opacity: (localeMode == item['localeMode'] ||
                          (localeMode == '' && item['localeMode'] == 'system'))
                      ? 1
                      : 0,
                  child: Icon(Icons.done, color: themeColor),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// theme_test.dart
/// author: Huxiaoyou
/// description: 主题设置页面

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/xb_form/xb_set_cell.dart';
import 'package:flutter_demo01/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeTestPage extends StatefulWidget {
  const ThemeTestPage({super.key});

  @override
  State<ThemeTestPage> createState() => _ThemeTestPageState();
}

class _ThemeTestPageState extends State<ThemeTestPage> {
  var _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('主题设置'),
      body: _body(),
    );
  }

  Widget _body() {
    final provider = Provider.of<ThemeProvider>(context);
    _isOpen = provider.isFollowSystem;

    Widget topWidget = XbSetCell(
      title: '跟随系统',
      hiddenLine: true,
      hiddenArrow: true,
      rightWidget: CupertinoSwitch(
        value: _isOpen,
        onChanged: (value) {
          setState(() {
            _isOpen = value;
            if (_isOpen) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(ThemeMethod.themeSystem);
            } else {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(ThemeMethod.themeLight);
            }
          });
        },
      ),
    );

    List dataArr = provider.getThemeList();
    List<Widget> widgetList = dataArr.map((item) => _cell(item)).toList();
    widgetList.insert(0, topWidget);

    return ListView(
      children: widgetList,
    );
  }

  Widget _cell(item) {
    final provider = Provider.of<ThemeProvider>(context);

    return Visibility(
      visible: !_isOpen,
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          color: item['value'],
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  item['label'],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Opacity(
                opacity: provider.getThemeColor() == item['value'] ? 1 : 0,
                child: const Icon(Icons.done, color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () => _onClickCell(item),
      ),
    );
  }

  _onClickCell(item) {
    print('选中主题: $item');
    setState(() {
      Provider.of<ThemeProvider>(context, listen: false).setTheme(item['themeMode']);
    });
  }
}

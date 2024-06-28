import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_tag_view.dart';
import 'package:flutter_demo01/configs/colors.dart';

class TagViewTestPage extends StatefulWidget {
  const TagViewTestPage({Key? key}) : super(key: key);

  @override
  State<TagViewTestPage> createState() => _TagViewTestPageState();
}

class _TagViewTestPageState extends State<TagViewTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('XbTagView'),
      body: _body(),
      backgroundColor: KColors.dynamicColor(context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  _body() {
    return ListView(children: const [
      Column(children: [
        XbTagView(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        SuccessTag(text: 'success'),
        ErrorTag(text: 'error'),
        WarningTag(text: 'warning'),
        SuccessTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        ErrorTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        WarningTag(textList: ['111', '22', '333', '44444', '5555555', '66666', '7777']),
        Row(
          children: [
            Text('Left'),
            SizedBox(width: 10),
            Expanded(
                child: XbTagView(
                    textList: ['123456789123456789123456789123456789123456789123456789', '111', '22', '333'])),
            SizedBox(width: 10),
            Text('Right'),
          ],
        ),
      ])
    ]);
  }
}

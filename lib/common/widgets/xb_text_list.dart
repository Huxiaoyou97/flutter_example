/// xb_text_list.dart
/// author: Huxiaoyou
/// description: 文字列表组件

import 'package:flutter/material.dart';
import 'package:flutter_demo01/configs/colors.dart';
import '/base_appbar.dart';

const double _lfSpace = 10.0;
const double _cellHeight = 50.0;
const double _lineHeight = 1.0;
const Color _lineColor = KColors.kLineColor;
const Color _lineDarkColor = KColors.kLineDarkColor;
const Color _cellBgColor = KColors.kCellBgColor;
const Color _cellBgDarkColor = KColors.kCellBgDarkColor;

class XbTextList extends StatefulWidget {
  const XbTextList({
    Key? key,
    this.dataArr = const [],
    this.callBack,
  }) : super(key: key);

  final List dataArr;
  final Function(int selectIndex, String selectStr)? callBack;

  @override
  State<XbTextList> createState() => _XbTextListState();
}

class _XbTextListState extends State<XbTextList> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: BaseAppBar(widget.title),
    //   body: _body(),
    // );
    return _body();
  }

  _body() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.dataArr.length,
      itemBuilder: (BuildContext context, int index) {
        return _itemWidget(index);
      },
    );
  }

  Widget _itemWidget(index) {
    var lineColor = KColors.dynamicColor(context, _lineColor, _lineDarkColor);
    var cellBgColor =
        KColors.dynamicColor(context, _cellBgColor, _cellBgDarkColor);

    return InkWell(
      child: Container(
        height: _cellHeight,
        color: cellBgColor,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(left: _lfSpace, child: Text(widget.dataArr[index])),
            const Positioned(
              right: _lfSpace,
              child: Icon(Icons.arrow_forward_ios,
                  size: 18, color: Color(0xFFC8C8C8)),
            ),
            Positioned(
                bottom: 0.0,
                left: _lfSpace,
                right: 0,
                child: Container(color: lineColor, height: _lineHeight)),
          ],
        ),
      ),
      onTap: () => widget.callBack?.call(index, widget.dataArr[index]),
    );
  }
}

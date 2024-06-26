/// xb_form_select_cell.dart
/// author: Huxiaoyou
/// description: 选择行样式，左侧title,右侧箭头文字

import 'package:flutter/material.dart';
import 'package:flutter_demo01/configs/colors.dart';

import 'xb_text_field.dart';

const double _titleSpace = 100.0; // 左侧title默认宽
const double _cellHeight = 45.0; // 输入、选择样式一行的高度
const double _lineHeight = 0.6; // 底部线高
const double _titleFontSize = 15.0;
const double _textFontSize = 15.0;
const double _hintTextFontSize = 15.0;

typedef _ClickCallBack = void Function();

class XbFormSelectCell extends StatefulWidget {
  const XbFormSelectCell({
    Key? key,
    this.title = '',
    this.text = '',
    this.hintText = '请选择',
    this.labelText = '',
    this.errorText = '',
    this.showRedStar = false,
    this.hiddenArrow = false,
    this.leftWidget,
    this.rightWidget,
    this.clickCallBack,
    this.space = _titleSpace,
    this.titleStyle,
    this.textStyle,
    this.hintTextStyle,
    this.labelTextStyle,
    this.textAlign = TextAlign.left,
    this.border = InputBorder.none, // 去掉下划线
    this.hiddenLine = false,
    this.topAlign = false,
    this.bgColor,
  }) : super(key: key);

  final String title;
  final String? text;
  final String hintText;
  final String labelText; // top提示文字
  final String errorText; // 错误提示文字
  final bool showRedStar; // 显示左侧小红星，默认不显示
  final bool hiddenArrow; // 隐藏箭头，默认不隐藏
  final Widget? leftWidget; // 左侧widget ，默认隐藏
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final _ClickCallBack? clickCallBack;
  final double space; // 标题宽度
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle; // 默认为hintTextStyle，高亮为主题色
  final TextAlign textAlign; // 输入文字对齐方式，默认左对齐
  final InputBorder border; // 输入边框样式，默认无边框
  final bool hiddenLine; // 隐藏底部横线
  final bool topAlign; // 左侧标题顶部对齐，默认居中
  final Color? bgColor; // 背景颜色，默认白色

  @override
  _XbFormSelectCellState createState() => _XbFormSelectCellState();
}

class _XbFormSelectCellState extends State<XbFormSelectCell> {
  bool _hiddenArrow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hiddenArrow = widget.hiddenArrow;
    if (widget.border != InputBorder.none) {
      _hiddenArrow = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    double starW = widget.showRedStar == false && widget.title.isEmpty ? 0 : 8;
    double topSpace = 0; // title 顶对齐 间距

    // 默认颜色
    var bgColor =
        KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);
    var titleColor = KColors.dynamicColor(
        context, KColors.kFormTitleColor, KColors.kFormTitleDarkColor);
    var titleStyle = TextStyle(fontSize: _titleFontSize, color: titleColor);
    var textColor = KColors.dynamicColor(
        context, KColors.kFormInfoColor, KColors.kFormInfoDarkColor);
    var textStyle = TextStyle(fontSize: _textFontSize, color: textColor);
    var hintColor = KColors.dynamicColor(
        context, KColors.kFormHintColor, KColors.kFormHintDarkColor);
    var hintTextStyle =
        TextStyle(fontSize: _hintTextFontSize, color: hintColor);
    var lineColor = KColors.dynamicColor(
        context, KColors.kFormLineColor, KColors.kFormLineDarkColor);

    // 设置的颜色优先级高于暗黑模式
    bgColor = widget.bgColor ?? bgColor;
    titleStyle = widget.titleStyle ?? titleStyle;
    textStyle = widget.textStyle ?? textStyle;
    hintTextStyle = widget.hintTextStyle ?? hintTextStyle;

    return Material(
      color: bgColor,
      child: InkWell(
        onTap: () => widget.clickCallBack?.call(),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: double.infinity, // 宽度尽可能大
            minHeight: _cellHeight, // 最小高度为50像素
          ),
          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
          decoration: UnderlineTabIndicator(
            // borderSide: BorderSide(width: _lineHeight, color: widget.hiddenLine== true ?Colors.transparent:Theme.of(context).dividerColor),
            borderSide: BorderSide(
              width: _lineHeight,
              color: widget.hiddenLine == true ? Colors.transparent : lineColor,
            ),
            insets: EdgeInsets.fromLTRB(starW, 0, 0, 0),
          ),
          child: Row(
            crossAxisAlignment: widget.topAlign == true
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: <Widget>[
              widget.leftWidget ?? Container(),
              Container(
                width: starW,
                padding: EdgeInsets.fromLTRB(
                    0, widget.topAlign == true ? topSpace : 0, 0, 0),
                child: Text(widget.showRedStar ? '*' : ' ',
                    style: const TextStyle(fontSize: 18.0, color: Colors.red)),
              ),
              Offstage(
                offstage: widget.title.isEmpty ? true : false,
                child: Container(
                  width: widget.space - starW,
                  padding: EdgeInsets.fromLTRB(
                      0, widget.topAlign == true ? topSpace : 0, 0, 0),
                  child: Text(widget.title, style: titleStyle),
                ),
              ),
              Expanded(
                child: XbTextField(
                  text: widget.text,
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  errorText: widget.errorText,
                  enabled: false,
                  textStyle: textStyle,
                  hintTextStyle: hintTextStyle,
                  labelTextStyle: widget.labelTextStyle,
                  textAlign: widget.textAlign,
                  border: widget.border,
                ),
              ),
              widget.rightWidget ?? Container(),
              Offstage(
                offstage: _hiddenArrow,
                child: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Color(0xFFC8C8C8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

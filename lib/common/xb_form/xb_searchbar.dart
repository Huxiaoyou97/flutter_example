/// xb_searchbar.dart
/// author: Huxiaoyou
/// description: 搜索框

import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/xb_form/xb_login_text_field.dart';
import 'package:flutter_demo01/configs/colors.dart';

const double kSearchViewHeight = 58.0;
const String _hintText = '请输入';
const double _borderRadius = 5.0;
const double _borderWidth = 0.3;
const EdgeInsetsGeometry _contentPadding = EdgeInsets.symmetric(vertical: 0);

typedef _InputCallBack = void Function(String value);
typedef _InputCompletionCallBack = void Function(String value, bool isSubmitted);

class XbSearchBar extends StatelessWidget {
  const XbSearchBar({
    Key? key,
    this.text = '',
    this.hintText = _hintText,
    this.maxLength = 15,
    this.bgColor,
    this.isShowDeleteBtn = true,
    this.isShowBorder = false,
    this.contentPadding = _contentPadding,
    this.textInputAction = TextInputAction.done,
    this.margin = const EdgeInsets.all(10),
    this.leftWidget = const Icon(Icons.search, size: 25),
    this.rightWidget,
    this.focusNode,
    this.tapCallBack,
    this.inputCallBack,
    this.inputCompletionCallBack,
  }) : super(key: key);

  final String? text;
  final String hintText;
  final int maxLength; // 最大长度，默认15
  final Color? bgColor;
  final bool isShowDeleteBtn; // 是否显示右侧删除按钮，默认显示
  final bool isShowBorder; // 是否显示边框，默认不显示
  final EdgeInsetsGeometry contentPadding; // 当父组件固定高度时，文本一行显示文本过多会出现文字显示不全bug,可设置EdgeInsets.symmetric(vertical: 0)
  final TextInputAction? textInputAction; // 键盘右下角按钮类型
  final EdgeInsetsGeometry? margin;
  final FocusNode? focusNode;
  final Widget? leftWidget; // 左侧widget ，默认显示搜索图标
  final Widget? rightWidget; // 右侧widget ，默认隐藏
  final void Function()? tapCallBack; // 点击搜索框回调
  final _InputCallBack? inputCallBack;
  final _InputCompletionCallBack? inputCompletionCallBack;

  @override
  Widget build(BuildContext context) {
    // 默认颜色
    var viewBgColor = KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor);
    var searchBarBgColor = KColors.dynamicColor(context, KColors.kSearchBarBgColor, KColors.kSearchBarBgDarkColor);
    var searchBarBorderColor = KColors.dynamicColor(context, Colors.grey, KColors.kLineDarkColor);
    // 设置的颜色优先级高于暗黑模式
    viewBgColor = bgColor ?? viewBgColor;

    return Container(
      color: viewBgColor,
      child: Container(
        decoration: BoxDecoration(
          color: searchBarBgColor,
          border: isShowBorder ? Border.all(color: searchBarBorderColor, width: _borderWidth) : null,
          borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
        ),
        alignment: Alignment.center,
        margin: margin,
        height: kSearchViewHeight - 20,
        child: XbLoginTextField(
          maxLength: maxLength,
          leftWidget: const Icon(Icons.search, size: 25),
          rightWidget: this.rightWidget,
          text: text,
          hintText: hintText,
          isShowDeleteBtn: isShowDeleteBtn,
          border: InputBorder.none,
          contentPadding: contentPadding,
          textInputAction: textInputAction,
          focusNode: focusNode,
          tapCallBack: tapCallBack,
          inputCallBack: inputCallBack,
          inputCompletionCallBack: inputCompletionCallBack,
        ),
      ),
    );
  }
}

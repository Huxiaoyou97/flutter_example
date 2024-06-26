import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/utils/xb_toast.dart';
import 'package:flutter_demo01/common/widgets/xb_dialog.dart';
import 'package:flutter_demo01/common/widgets/xb_picker_tool.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';
import 'package:flutter_demo01/common/xb_form/xb_form_input_cell.dart';
import 'package:flutter_demo01/common/xb_form/xb_form_select_cell.dart';
import 'package:flutter_demo01/common/xb_form/xb_form_utils.dart';
import 'package:flutter_demo01/configs/colors.dart';

class DialogTestPage extends StatefulWidget {
  const DialogTestPage({Key? key}) : super(key: key);

  @override
  State<DialogTestPage> createState() => _DialogTestPageState();
}

class _DialogTestPageState extends State<DialogTestPage> {
  final List titleData = [
    'XbDialog-标题',
    'XbDialog-标题不加粗',
    'XbDialog-标题内容',
    'XbDialog-内容',
    'XbDialog-标题内容只有确定',
    'XbDialog-修改按钮文字',
    'XbDialog-点击按钮弹框不消失',
    'XbDialog-拦截取消按钮点击事件',
    'XbDialog-录入框',
    'XbDialog-自定义内容',
    'XbDialog-自定义内容2',
    'XbDialog-自定义内容3-录入框',
    'XbDialog-自定义内容4-选择类型更新数据',
    'XbDialog-自定义内容5-选择类型更新数据2',
    'XbDialog-完全自定义',
    'XbDialog-完全自定义-外部点击事件',
  ];

  final dictArr = [
    {'label': '类型一', 'value': '1'},
    {'label': '类型二', 'value': '2'},
    {'label': '类型三', 'value': '3'},
  ];
  var _selectItem = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('XbDialog'),
      body: XbTextList(
        dataArr: titleData,
        callBack: (index, str) {
          if (str == 'XbDialog-标题') {
            XbDialog.show(context, title: '提示', onConfirm: () {
              XbToast.showText(context, msg: '点击确定');
            });
          }
          if (str == 'XbDialog-标题不加粗') {
            XbDialog.show(context, title: '提示', isBoldTitle: false);
          }
          if (str == 'XbDialog-标题内容') {
            XbDialog.show(context, title: '提示', content: '您确定要退出登录吗？');
          }
          if (str == 'XbDialog-内容') {
            XbDialog.show(context, content: '确认要退出吗？');
          }
          if (str == 'XbDialog-标题内容只有确定') {
            XbDialog.show(context,
                title: '警告',
                content: '您的账号在异地登录，请重新登录！',
                rightText: '好的',
                hiddenCancel: true);
          }
          if (str == 'XbDialog-修改按钮文字') {
            XbDialog.show(context,
                title: '提示',
                content: '您需要同意相关协议才能使用！',
                leftText: '不同意',
                rightText: '同意');
          }
          if (str == 'XbDialog-点击按钮弹框不消失') {
            XbDialog.show(context,
                title: '提示',
                content: '点击取消按钮弹框消失，点击确认按钮延时3秒后弹框消失',
                clickBtnPop: false, onConfirm: () {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pop(context);
              });
            });
          }
          if (str == 'XbDialog-拦截取消按钮点击事件') {
            XbDialog.show(context,
                title: '提示', content: '点击取消按钮弹框不消失，点击确认按钮弹框消失', onConfirm: () {
              XbToast.showText(context, msg: '点击确定');
            }, onCancel: () {
              XbToast.showText(context, msg: '点击取消');
            });
          }
          if (str == 'XbDialog-录入框') {
            var inputValue = '';
            XbDialog.showInputDialog(
              context,
              title: '提示',
              inputText: inputValue,
              hintText: 'number',
              labelText: 'number',
              keyboardType: TextInputType.number,
              inputFormatters: [number, length5],
              inputCallBack: (value) => inputValue = value,
              onConfirm: () {
                if (inputValue.isEmpty) {
                  XbProgressHUD.showText('Please input number');
                  return;
                }
                // 手动隐藏弹框
                XbDialog.hide(context);
                XbProgressHUD.showText('number: $inputValue');
                print('inputValue: $inputValue');
              },
            );
          }

          if (str == 'XbDialog-自定义内容') {
            XbDialog.showCustomDialog(context,
                content: Container(height: 200, color: Colors.red));
          }
          if (str == 'XbDialog-自定义内容2') {
            XbDialog.showCustomDialog(context,
                title: '提示',
                content: Container(height: 200, color: Colors.red));
          }
          if (str == 'XbDialog-自定义内容3-录入框') {
            _showInputDialog();
          }
          if (str == 'XbDialog-自定义内容4-选择类型更新数据') {
            var params = {
              'id': '123',
              'type': '456',
            };
            _showSelectDialog(params);
          }
          if (str == 'XbDialog-自定义内容5-选择类型更新数据2') {
            var params = {
              'id': '123',
              'type': '456',
            };
            _showSelectDialog2(params);
          }
          if (str == 'XbDialog-完全自定义') {
            XbDialog.showAllCustomDialog(
              context,
              clickBgHidden: true,
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.red,
                  child: const Center(child: Text('这是完全自定义的弹框，点击背景隐藏')),
                ),
              ),
            );
          }
          if (str == 'XbDialog-完全自定义-外部点击事件') {
            XbDialog.showAllCustomDialog(
              context,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print('这是完全自定义的弹框，点击红色部分隐藏');
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.red,
                  child: const Center(child: Text('这是完全自定义的弹框，点击红色部分隐藏')),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  _showInputDialog() async {
    var inputValue = '';
    XbDialog.showCustomDialog(
      context,
      title: '请输入数字',
      isBoldTitle: false,
      clickBtnPop: false,
      content: StatefulBuilder(builder: (context, state) {
        var lineColor = KColors.dynamicColor(
            context, KColors.kLineColor, KColors.kLineDarkColor);
        var bgColor = KColors.dynamicColor(context, KColors.kAlertInputBgColor,
            KColors.kAlertInputBgDarkColor);

        return Container(
          height: 55,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: lineColor, width: 1),
          ),
          child: XbFormInputCell(
            bgColor: Colors.transparent,
            text: inputValue,
            hiddenLine: true,
            labelText: 'number',
            keyboardType: TextInputType.number,
            inputFormatters: [number, length100],
            inputCallBack: (value) => inputValue = value,
          ),
        );
      }),
      onCancel: () => XbDialog.hide(context),
      onConfirm: () {
        if (inputValue.isEmpty) {
          XbProgressHUD.showText('Please input number');
          return;
        }

        XbDialog.hide(context);
        XbProgressHUD.showText('number: $inputValue');
        print('inputValue: $inputValue');
      },
    );
  }

  _showSelectDialog(params) async {
    XbDialog.showCustomDialog(
      context,
      title: '请选择类型',
      isBoldTitle: false,
      clickBtnPop: false,
      content: StatefulBuilder(builder: (context, state) {
        var lineColor = KColors.dynamicColor(
            context, KColors.kLineColor, KColors.transparent);
        return IntrinsicHeight(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration:
                BoxDecoration(border: Border.all(color: lineColor, width: 0.5)),
            child: Column(
              children: [
                XbFormSelectCell(
                  showRedStar: true,
                  hiddenLine: true,
                  text: _selectItem['label'],
                  labelText: '类型',
                  clickCallBack: () => _showPicker(state),
                ),
              ],
            ),
          ),
        );
      }),
      onConfirm: () => _jumpPage(params, true),
      onCancel: () => XbDialog.hide(context),
    );
  }

  _showSelectDialog2(params) async {
    var title = '请选择类型';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, state) {
            var lineColor = KColors.dynamicColor(
                context, KColors.kLineColor, KColors.transparent);

            return BaseDialog(
              title: title,
              isBoldTitle: false,
              clickBtnPop: false,
              content: Container(
                height: 57,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: lineColor, width: 1)),
                child: Column(children: [
                  XbFormSelectCell(
                    showRedStar: true,
                    hiddenLine: true,
                    text: _selectItem['label'],
                    labelText: '类型',
                    clickCallBack: () {
                      _showPicker(state);
                    },
                  ),
                ]),
              ),
              onConfirm: () => _jumpPage(params, true),
              onCancel: () {
                state(() {
                  _selectItem = {};
                });
                XbDialog.hide(context);
              },
            );
          },
        );
      },
    );
  }

  _showPicker(state) {
    XbPickerTool.showStringPicker(context,
        data: dictArr,
        title: '请选择类型',
        labelKey: 'label',
        selectIndex: 1, clickCallBack: (selectValue, selectIndex) {
      print(selectValue);
      print(selectValue['label']);
      print(selectIndex);
      state(() {
        _selectItem = selectValue;
      });
    });
  }

  _jumpPage(params, isShowDialog) {
    if (_selectItem.isEmpty) {
      XbProgressHUD.showText('请选择类型');
      return;
    }

    XbDialog.hide(context);
    XbProgressHUD.showText('验证通过，进行其他操作');
    print('params: $params');
  }
}

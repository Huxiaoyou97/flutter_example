import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_cascade_picker.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';

final List titleData = [
  'XbCascadePicker-单列',
  'XbCascadePicker-两列',
  'XbCascadePicker-三列',
  'XbCascadePicker-四列',
  'XbCascadePicker-五列',
];

final columnData0 = [
  {'value': '011', 'label': '超大类1'},
  {'value': '022', 'label': '超大类2'},
  {'value': '033', 'label': '超大类3'},
  {'value': '044', 'label': '超大类4'},
  {'value': '055', 'label': '超大类5'},
  {'value': '066', 'label': '超大类6'},
  {'value': '077', 'label': '超大类7'},
  {'value': '088', 'label': '超大类8'},
  {'value': '099', 'label': '超大类9'},
];

final columnData1 = [
  {'value': '1', 'label': '大类1'},
  {'value': '2', 'label': '大类2'},
  {'value': '3', 'label': '大类3'},
  {'value': '4', 'label': '大类4'},
];
final columnData2 = [
  {'value': '11', 'label': '中类1'},
  {'value': '22', 'label': '中类2'},
  {'value': '33', 'label': '中类3'},
  {'value': '44', 'label': '中类4'},
];
final columnData3 = [
  {'value': '111', 'label': '小类1'},
  {'value': '222', 'label': '小类2'},
  {'value': '333', 'label': '小类3'},
  {'value': '444', 'label': '小类4'},
];

final columnData4 = [
  {'value': '1111', 'label': '超小类1'},
  {'value': '2222', 'label': '超小类2'},
  {'value': '3333', 'label': '超小类3'},
  {'value': '4444', 'label': '超小类4'},
  {'value': '5555', 'label': '超小类5'},
  {'value': '6666', 'label': '超小类6'},
  {'value': '7777', 'label': '超小类7'},
  {'value': '8888', 'label': '超小类8'},
  {'value': '9999', 'label': '超小类9'},
];

class CascadePickerTest extends StatelessWidget {
  const CascadePickerTest({super.key});

  @override
  Widget build(BuildContext context) {
    List dataArr1 = [columnData1];
    List dataArr2 = [columnData1, columnData3];
    List dataArr3 = [columnData1, columnData2, columnData3];
    List dataArr4 = [columnData1, columnData2, columnData3, columnData4];
    List dataArr5 = [
      columnData0,
      columnData1,
      columnData2,
      columnData3,
      columnData4
    ];

    return Scaffold(
      appBar: BaseAppBar("XbCascadePicker"),
      body: XbTextList(
          dataArr: titleData,
          callBack: (index, str) {
            if (str == 'XbCascadePicker-单列') {
              XbCascadePicker.show(context,
                  data: dataArr1,
                  labelKey: 'label',
                  title: '请选择类型',
                  tabText: '请选择2', clickCallBack: (selectValue) {
                print(selectValue);
                showText(selectValue);
              });
            }
            if (str == 'XbCascadePicker-两列') {
              XbCascadePicker.show(context,
                  data: dataArr2,
                  labelKey: 'label',
                  title: '请选择类型', clickCallBack: (selectValue) {
                print(selectValue);
                showText(selectValue);
              });
            }
            if (str == 'XbCascadePicker-三列') {
              XbCascadePicker.show(context,
                  data: dataArr3,
                  labelKey: 'label',
                  title: '请选择类型', clickCallBack: (selectValue) {
                print(selectValue);
                showText(selectValue);
              });
            }
            if (str == 'XbCascadePicker-四列') {
              XbCascadePicker.show(context,
                  data: dataArr4,
                  labelKey: 'label',
                  title: '请选择类型', clickCallBack: (selectValue) {
                print(selectValue);
                showText(selectValue);
              });
            }
            if (str == 'XbCascadePicker-五列') {
              XbCascadePicker.show(context,
                  data: dataArr5,
                  labelKey: 'label',
                  title: '请选择类型', clickCallBack: (selectValue) {
                print(selectValue);
                showText(selectValue);
              });
            }
          }),
    );
  }
}

void showText(str) {
  XbProgressHUD.showText(str.toString());
}

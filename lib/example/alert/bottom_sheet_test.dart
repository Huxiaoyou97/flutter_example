
import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/utils/xb_time_utils.dart';
import 'package:flutter_demo01/common/widgets/xb_bottom_sheet.dart';
import 'package:flutter_demo01/common/widgets/xb_multi_picker.dart';
import 'package:flutter_demo01/common/widgets/xb_picker_tool.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_text_list.dart';

final List titleData = [
  'XbBottomSheet-不带标题',
  'XbBottomSheet-带标题',
  'XbBottomSheet-红色',
  'XbPickerTool-单列（字符串数组）',
  'XbPickerTool-单列（对象数组）',
  'XbPickerTool-两列（字符串数组）',
  'XbPickerTool-两列（对象数组）',
  'XbPickerTool-三列（字符串数组）',
  'XbPickerTool-三列（对象数组）',
  'XbPickerTool-时间选择YMD（默认YMD）',
  'XbPickerTool-时间选择YM',
  'XbPickerTool-时间选择YMD_HM',
  'XbPickerTool-时间选择YMD_AP_HM',
  'XbPickerTool-时间选择设置最大最小时间',
  'XbMultiPicker-多选（对象数组）',
];

final stringArr = ['11', '22', '33', '44'];

final dictArr = [
  {'label': '类型一', 'value': '1'},
  {'label': '类型二', 'value': '2'},
  {'label': '类型三', 'value': '3'},
];

final stringArr2 = [
  ['11', '22'],
  ['33', '44'],
];

final dictArr2 = [
  [
    {'label': '大类一', 'value': '1'},
    {'label': '大类二', 'value': '2'},
    {'label': '大类三', 'value': '3'},
  ],
  [
    {'label': '小类一', 'value': '1'},
    {'label': '小类二', 'value': '2'},
  ],
];

final stringArr3 = [
  ['11', '22'],
  ['33', '44'],
  ['55', '66']
];

final dictArr3 = [
  [
    {'label': '大类一', 'value': '1'},
    {'label': '大类二', 'value': '2'},
    {'label': '大类三', 'value': '3'},
  ],
  [
    {'label': '中类一', 'value': '1'},
    {'label': '中型二', 'value': '2'},
    {'label': '中型三', 'value': '3'},
    {'label': '中型四', 'value': '4'},
  ],
  [
    {'label': '小类一', 'value': '1'},
    {'label': '小类二', 'value': '2'},
  ],
];

final multiDictArr = [
  {'label': '类型一', 'value': '1'},
  {'label': '类型二', 'value': '2'},
  {'label': '类型三', 'value': '3'},
  {'label': '类型四', 'value': '4'},
  {'label': '类型五', 'value': '5'},
  {'label': '类型六', 'value': '6'},
  {'label': '类型七类型七类型七类型七', 'value': '7'},
  {'label': '类型八类型八类型八类型八类型八类型八类型八类型八类型八类型八', 'value': '8'},
  {'label': '类型九', 'value': '9'},
];

class BottomSheetTest extends StatelessWidget {
  const BottomSheetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar("BottomSheetTest"),
      body: XbTextList(
          dataArr: titleData,
          callBack: (index, str) {
            if (str == 'XbBottomSheet-不带标题') {
              XbBottomSheet.showText(context, dataArr: ['hello', 'world', '123'], clickCallback: (index, text) {
                print(index);
                print(text);
                showText(text);
              });
            }
            if (str == 'XbBottomSheet-带标题') {
              XbBottomSheet.showText(context, dataArr: ['hello', 'world', '123'], title: '请选择',
                  clickCallback: (index, text) {
                    print(index);
                    print(text);
                    showText(text);
                  });
            }
            if (str == 'XbBottomSheet-红色') {
              XbBottomSheet.showText(context, title: '请选择操作', dataArr: ['保存本地'], redBtnTitle: '删除',
                  clickCallback: (index, text) {
                    print(index);
                    print(text);
                    showText(text);
                  });
            }

            if (str == 'XbPickerTool-单列（字符串数组）') {
              XbPickerTool.showStringPicker(context, data: stringArr, selectIndex: 1,
                  clickCallBack: (selectValue, selectIndex) {
                    print(selectValue);
                    print(selectIndex);
                    showText(selectValue);
                  });
            }
            if (str == 'XbPickerTool-单列（对象数组）') {
              XbPickerTool.showStringPicker(context, data: dictArr, title: '请选择类型', labelKey: 'label', selectIndex: 2,
                  clickCallBack: (selectValue, selectIndex) {
                    print(selectValue);
                    print(selectValue['label']);
                    print(selectIndex);
                    showText(selectValue);
                  });
            }
            if (str == 'XbPickerTool-两列（字符串数组）') {
              XbPickerTool.showArrayPicker(context, data: stringArr2, selectIndex: [0, 1],
                  clickCallBack: (selectItemArr, selectIndexArr) {
                    print(selectItemArr);
                    print(selectIndexArr);
                    showText(selectItemArr);
                  });
            }
            if (str == 'XbPickerTool-两列（对象数组）') {
              XbPickerTool.showArrayPicker(context,
                  data: dictArr2,
                  title: '请选择类型',
                  labelKey: 'label',
                  selectIndex: [1, 1], clickCallBack: (selectItemArr, selectIndexArr) {
                    print(selectItemArr);
                    print(selectIndexArr);
                    print(dictArr2[0][selectIndexArr[0]]);
                    print(dictArr2[1][selectIndexArr[1]]);
                    showText(selectItemArr);
                  });
            }

            if (str == 'XbPickerTool-三列（字符串数组）') {
              XbPickerTool.showArrayPicker(context, data: stringArr3, selectIndex: [0, 1, 0],
                  clickCallBack: (selectItemArr, selectIndexArr) {
                    print(selectItemArr);
                    print(selectIndexArr);
                    showText(selectItemArr);
                  });
            }
            if (str == 'XbPickerTool-三列（对象数组）') {
              XbPickerTool.showArrayPicker(context,
                  data: dictArr3,
                  title: '请选择类型',
                  labelKey: 'label',
                  selectIndex: [1, 2, 1], clickCallBack: (selectItemArr, selectIndexArr) {
                    print(selectItemArr);
                    print(selectIndexArr);
                    print(dictArr3[0][selectIndexArr[0]]);
                    print(dictArr3[1][selectIndexArr[1]]);
                    print(dictArr3[2][selectIndexArr[2]]);
                    showText(selectItemArr);
                  });
            }
            if (str == 'XbPickerTool-时间选择YMD（默认YMD）') {
              XbPickerTool.showDatePicker(context, clickCallBack: (selectValue, selectIndexArr) {
                print(selectValue);
                print(selectIndexArr);
                showText(selectValue);
              });
            }
            if (str == 'XbPickerTool-时间选择YM') {
              XbPickerTool.showDatePicker(context, dateType: PickerDateType.YM,
                  clickCallBack: (selectValue, selectIndexArr) {
                    print(selectValue);
                    print(selectIndexArr);
                    showText(selectValue);
                  });
            }
            if (str == 'XbPickerTool-时间选择YMD_HM') {
              XbPickerTool.showDatePicker(context, dateType: PickerDateType.YMD_HM,
                  clickCallBack: (selectValue, selectIndexArr) {
                    print(selectValue);
                    print(selectIndexArr);
                    showText(selectValue);
                  });
            }
            if (str == 'XbPickerTool-时间选择YMD_AP_HM') {
              XbPickerTool.showDatePicker(context, dateType: PickerDateType.YMD_AP_HM,
                  clickCallBack: (selectValue, selectIndexArr) {
                    print(selectValue);
                    print(selectIndexArr);
                    showText(selectValue);
                  });
            }
            if (str == 'XbPickerTool-时间选择设置最大最小时间') {
              XbPickerTool.showDatePicker(context,
                  title: '请选择时间',
                  minTime: DateTime(int.parse(XbTimeUtils.getYear()) - 1, 10, 10),
                  maxTime: DateTime(int.parse(XbTimeUtils.getYear()) + 1, 10, 10),
                  selectTime: DateTime(int.parse(XbTimeUtils.getYear()), 10, 10),
                  clickCallBack: (selectValue, selectIndexArr) {
                    print(selectValue);
                    print(selectIndexArr);
                    showText(selectValue);
                  });
            }

            if (str == 'XbMultiPicker-多选（对象数组）') {
              XbMultiPicker.show(context, data: multiDictArr, values: ['3', '5'], title: '选择类型',
                  clickCallBack: (selectValues, selectItemArr) {
                    print('selectValues==  $selectValues');
                    print('selectItemArr==  $selectItemArr');
                    showText(selectValues);
                  });
            }
          }),
    );
  }
}

void showText(text) {
  XbProgressHUD.showText(text.toString());

  // Fluttertoast.showToast(
  //   msg: str.toString(),
  //   gravity: ToastGravity.CENTER,
  //   backgroundColor: Colors.black,
  // );

//  Fluttertoast.showToast(
//      msg: 'This is Center Short Toast',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIos: 1,
//      backgroundColor: Colors.red,
//      textColor: Colors.white,
//      fontSize: 16.0
//  );
}

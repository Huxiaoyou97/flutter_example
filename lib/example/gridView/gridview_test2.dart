import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/utils/xb_toast.dart';
import 'package:flutter_demo01/common/widgets/xb_bottom_sheet.dart';
import 'package:flutter_demo01/common/widgets/xb_nine_picture.dart';
import '/base_appbar.dart';

List<String>? dataArr;
List<String>? dataArr2;

List getData() {
  dataArr = [];
  for (int i = 0; i < 9; i++) {
    String img;
    if (i % 2 == 0) {
      img = 'https://img2.baidu.com/it/u=913080836,1112754885&fm=253&fmt=auto&app=120&f=JPEG?w=512&h=500';
    } else {
      img = 'https://img1.baidu.com/it/u=1023452347,2490968251&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500';
    }
    dataArr!.add(img);
  }
  return dataArr!;
}

List getData2() {
  dataArr2 = [];
  for (int i = 0; i < 4; i++) {
    String img;
    if (i % 2 == 0) {
      img = 'https://img2.baidu.com/it/u=913080836,1112754885&fm=253&fmt=auto&app=120&f=JPEG?w=512&h=500';
    } else {
      img = 'https://img1.baidu.com/it/u=1023452347,2490968251&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500';
    }
    dataArr2!.add(img);
  }
  return dataArr2!;
}

class GridViewTest2 extends StatefulWidget {
  const GridViewTest2({Key? key}) : super(key: key);

  @override
  State<GridViewTest2> createState() => _GridViewTest2State();
}

class _GridViewTest2State extends State<GridViewTest2> {
  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('GridView实现朋友圈（九宫格）'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('九宫格'),
          Container(
              padding: const EdgeInsets.fromLTRB(80, 10, 30, 10),
              color: Colors.blue,
              child: XbNinePicture(
                imgData: dataArr,
                lRSpace: 110,
                onLongPress: (int index, dynamic imgArr) {
                  XbBottomSheet.showText(context, dataArr: ['保存图片']);
                },
              )),
          const Text('九宫格，4图未处理'),
          Container(
            padding: const EdgeInsets.fromLTRB(80, 10, 30, 10),
            color: Colors.blue,
            child: XbNinePicture(
              imgData: dataArr2,
              lRSpace: 110,
              isHandleFour: false,
              onLongPress: (int index, dynamic imgArr) {
                XbBottomSheet.showText(context, dataArr: ['保存图片'], clickCallback: (index, text) {
                  XbToast.showText(context, msg: "点击了$index  $text");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

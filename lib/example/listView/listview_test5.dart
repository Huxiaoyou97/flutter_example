import 'package:flutter/material.dart';
import 'package:flutter_demo01/common/utils/xb_image_utils.dart';
import '/base_appbar.dart';

var dataArr = [];

var phone = '1234xxxx1234';
var address = '这是地址';
var range = '这是描述这是描述';

var adminData = [
  {'title': 'title11', 'icon': 'service/icon_baoxiu', 'bgImg': 'service/bg_service_baoxiu'},
  {'title': 'title22', 'icon': 'service/icon_gongdan', 'bgImg': 'service/bg_service_gongdan'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'},
  {'title': 'title33', 'icon': 'service/icon_fuwufankui', 'bgImg': 'service/bg_service_fuwufankui'}
];

class ListViewTest5 extends StatelessWidget {
  const ListViewTest5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('这是标题'),
      body: ContentBody(),
    );
  }
}

class ContentBody extends StatelessWidget {
  ContentBody({Key? key}) : super(key: key) {
    dataArr = adminData;
  }

  Widget _getWidget(context, index) {
    return Container(
//        color: Colors.red,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
//              color: Colors.grey,
//              border: Border.all(width: 2.0, color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: XbImageUtils.getAssetImage(dataArr[index]['bgImg']),
          ),
        ),
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            title: Text(dataArr[index]['title'], style: const TextStyle(color: Colors.white, fontSize: 20)),
            leading: Image(image: XbImageUtils.getAssetImage(dataArr[index]['icon'])),
            onTap: () {
              print('点击的index ${index.toString()}');
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//  height: 100,
      color: Colors.yellow,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: dataArr.length,
              itemExtent: 150.0, // 强制高度为100.0
              itemBuilder: _getWidget,
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              child: bottomView,
            ),
          ],
        ),
      ),
    );

//      Container(
//      color: Colors.yellow,
//      height: MediaQuery.of(context).size.height,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Expanded(
//              child:
//
//              ListView.builder(
//                  itemCount: dataArr.length,
//                  itemExtent: 150.0, // 强制高度为100.0
//                  itemBuilder: this._getWidget
//              )
//
//          ),
//
//          ///下面控件位于Column布局底部
//          Container(
//            color: Colors.blue,
//            padding: EdgeInsets.fromLTRB(20, 0, 0, 50),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              crossAxisAlignment : CrossAxisAlignment.start,
//              children: <Widget>[
//                Text('热线: ${phone}',style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
//                SizedBox(height: 5),
//                Text('地址: ${address}',style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
//                SizedBox(height: 5),
//                Text('描述: ${range}',style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
//              ],
//            ),
//          )
//        ],
//      ),
//    );
  }
}

Widget bottomView = Container(
  color: Colors.blue,
//      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('热线: $phone', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
      const SizedBox(height: 5),
      Text('地址: $address', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
      const SizedBox(height: 5),
      Text('描述: $range', style: const TextStyle(fontSize: 20), textAlign: TextAlign.left),
    ],
  ),
);

Widget cell = Container(
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/service/lufei.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: const Column(),
);

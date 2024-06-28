import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_collapse_view.dart';
import 'package:flutter_demo01/configs/colors.dart';
import 'package:flutter_demo01/configs/styles.dart';

class CollapseViewTestPage extends StatefulWidget {
  const CollapseViewTestPage({Key? key}) : super(key: key);

  @override
  State<CollapseViewTestPage> createState() => _CollapseViewTestPageState();
}

class _CollapseViewTestPageState extends State<CollapseViewTestPage> {
  var _isFold = false;
  var _isFold2 = false;
  var _isFold3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('XbCollapseView'),
      body: _body(),
      backgroundColor: KColors.dynamicColor(
          context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  _body() {
    return ListView(children: [
      Column(children: [
        XbCollapseView(title: '标题', content: _testView()),
        XbCollapseView(
          title: '这是很长很长很长长很长很长很长很长很长很长很长很长很长很长的标题',
          titleStyle: TextStyle(color: Colors.white, fontSize: 13),
          arrowColor: Colors.white,
          headerColor: Color(0xFFA2BFEE),
          content: _testView(),
        ),
        XbCollapseView(
          titleWidget: _titleW(),
          titleCrossAxisAlignment: CrossAxisAlignment.start,
          arrowColor: Colors.white,
          headerColor: Color(0xFFA2BFEE),
          content: _testView(),
        ),
        XbCollapseView(
          titleWidget: _titleW2(),
          headerColor: Colors.white,
          content: _testView(),
        ),
        TextButton(
          child: Text('点击更新折叠状态'),
          onPressed: () {
            setState(() {
              _isFold = !_isFold;
            });
          },
        ),
        XbCollapseView(
          isFold: _isFold,
          title: 'isFold更新',
          content: _testView(),
          onChange: (isFold) {
            print('isFold:$isFold');
            setState(() {
              _isFold = isFold;
            });
          },
        ),
        XbCollapseView(
          title: 'card样式',
          collapseStyle: XbCollapseStyle.card,
          content: _testView(),
        ),
        XbCollapseView(
          title: '标题',
          collapseStyle: XbCollapseStyle.card,
          content: Container(
            child: Column(
              children: [
                separator(),
                _testView(),
              ],
            ),
          ),
        ),
        XbCollapseView(
          isFold: true,
          collapseStyle: XbCollapseStyle.card,
          headerColor: Colors.pink,
          // headerPadding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 1.5, blurRadius: 1.5)
            ],
          ),
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: KStyles.cellBorderStyle,
          child: XbCollapseView(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            title: '标题',
            titleStyle: TextStyle(color: Colors.white),
            arrowColor: Colors.white,
            headerColor: Color(0xFFA2BFEE),
            content: Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text('title$index'),
                      subtitle: Text('subtitle$index'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        XbCollapseView(
          title: '居中箭头card样式',
          isFold: true,
          collapseType: XbCollapseType.centerArrow,
          collapseStyle: XbCollapseStyle.card,
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        XbCollapseView(
          title: '居中箭头flat样式',
          isFold: true,
          collapseType: XbCollapseType.centerArrow,
          collapseStyle: XbCollapseStyle.flat,
          titleWidget: _titleW2(),
          content: _testView(),
        ),
        XbCollapseView(
          isFold: _isFold2,
          title: _isFold2 ? '查看更多' : '收起',
          collapseType: XbCollapseType.seeMore,
          titleWidget: _titleW2(),
          content: _testView(),
          onChange: (isFold) {
            print('isFold2:$isFold');
            setState(() {
              _isFold2 = isFold;
            });
          },
        ),
        XbCollapseView(
          isFold: _isFold3,
          title: _isFold3 ? '查看更多' : '收起',
          collapseType: XbCollapseType.seeMore,
          collapseStyle: XbCollapseStyle.card,
          hiddenDivider: true,
          titleWidget: _titleW2(),
          content: _testView(),
          onChange: (isFold) {
            print('isFold3:$isFold');
            setState(() {
              _isFold3 = isFold;
            });
          },
        ),
      ])
    ]);
  }

  _testView() {
    return Container(color: Colors.yellow, height: 100);
  }

  _titleW() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Text('1212222222222222222222222222222222222222222')),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.red,
                child: Text('自定义title',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
        // Icon(Icons.arrow_drop_down),
      ],
    );
  }

  _titleW2() {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(child: Text('custom title widget')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(child: Text('123')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('test:', style: KStyles.textBold15),
              SizedBox(width: 5),
              Expanded(
                  child: Text('1212222222222222222222222222222222222222222')),
            ],
          ),
        ],
      ),
    );
  }
}

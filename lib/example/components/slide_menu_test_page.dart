import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_slide_menu_view.dart';
import 'package:flutter_demo01/configs/colors.dart';

class SlideMenuTestPage extends StatefulWidget {
  const SlideMenuTestPage({Key? key}) : super(key: key);

  @override
  State<SlideMenuTestPage> createState() => _SlideMenuTestPageState();
}

class _SlideMenuTestPageState extends State<SlideMenuTestPage> {
  final _dataArr = [
    {
      'text': '天猫',
      'image': 'assets/images/funcMenu/天猫.png',
    },
    {
      'text': '聚划算',
      'image': 'assets/images/funcMenu/聚划算.png',
    },
    {
      'text': '天猫国际',
      'image': 'assets/images/funcMenu/天猫国际.png',
    },
    {
      'text': '外卖',
      'image': 'assets/images/funcMenu/外卖.png',
    },
    {
      'text': '天猫超市',
      'image': 'assets/images/funcMenu/天猫超市.png',
    },
    {
      'text': '充值中心',
      'image': 'assets/images/funcMenu/充值中心.png',
    },
    {
      'text': '飞猪旅行',
      'image': 'assets/images/funcMenu/飞猪旅行.png',
    },
    {
      'text': '领金币',
      'image': 'assets/images/funcMenu/领金币.png',
    },
    {
      'text': '拍卖',
      'image': 'assets/images/funcMenu/拍卖.png',
    },
    {
      'text': '分类',
      'image': 'assets/images/funcMenu/分类.png',
    },
    {
      'text': '方便速食',
      'image': 'assets/images/funcMenu/方便速食.png',
    },
    {
      'text': '休闲零食',
      'image': 'assets/images/funcMenu/休闲零食.png',
    },
    {
      'text': '奶品水饮',
      'image': 'assets/images/funcMenu/奶品水饮.png',
    },
    {
      'text': '粮油米面',
      'image': 'assets/images/funcMenu/粮油米面.png',
    },
    {
      'text': '厨房日用',
      'image': 'assets/images/funcMenu/厨房日用.png',
    },
    {
      'text': '母婴用品',
      'image': 'assets/images/funcMenu/母婴用品.png',
    },
    {
      'text': '个人护理',
      'image': 'assets/images/funcMenu/个人护理.png',
    },
    {
      'text': '家清家居',
      'image': 'assets/images/funcMenu/家清家居.png',
    },
    {
      'text': '进口好货',
      'image': 'assets/images/funcMenu/进口好货.png',
    },
    {
      'text': '新人包邮',
      'image': 'assets/images/funcMenu/新人包邮.png',
    },
  ];

  final _dataArr2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 15; i++) {
      var map = {};
      map['text'] = 'text$i';
      map['image'] = 'https://img1.baidu.com/it/u=1023452347,2490968251&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500';
      _dataArr2.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('XbSlideMenuView'),
      body: _body(),
      backgroundColor: KColors.dynamicColor(
          context, KColors.wxBgColor, KColors.kBgDarkColor),
    );
  }

  _body() {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            XbSlideMenuView(
              data: _dataArr,
              clickCallBack: (int selectIndex, dynamic selectItem) {
                print('点击第$selectIndex个');
                print(selectItem);
                XbProgressHUD.showText('点击了${selectItem['text']}');
              },
            ),
            const SizedBox(height: 30),
            XbSlideMenuView(
              data: _dataArr,
              maxRow: 1,
              maxColumn: 4,
              margin: 10,
              radius: 15,
              clickCallBack: (int selectIndex, dynamic selectItem) {
                print('点击第$selectIndex个');
                print(selectItem);
                XbProgressHUD.showText('点击了${selectItem['text']}');
              },
            ),
            const SizedBox(height: 30),
            const Text('网络图片'),
            XbSlideMenuView(
              data: _dataArr2,
              maxRow: 2,
              maxColumn: 4,
              margin: 10,
              radius: 5,
              // isShowSlider: false,
              clickCallBack: (int selectIndex, dynamic selectItem) {
                print('点击第$selectIndex个');
                print(selectItem);
                XbProgressHUD.showText('点击了${selectItem['text']}');
              },
            ),
          ],
        )
      ],
    );
  }
}

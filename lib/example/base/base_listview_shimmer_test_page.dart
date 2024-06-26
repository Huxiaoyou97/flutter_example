import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/base_refresh_view.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_shimmer_view.dart';
import 'package:flutter_demo01/configs/styles.dart';
import 'package:flutter_demo01/http/apis.dart';

class BaseListViewShimmerTestPage extends StatefulWidget {
  const BaseListViewShimmerTestPage({Key? key}) : super(key: key);

  @override
  State<BaseListViewShimmerTestPage> createState() => _BaseListViewShimmerTestPageState();
}

class _BaseListViewShimmerTestPageState extends State<BaseListViewShimmerTestPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      _requestData(isShowLoading: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'BaseListView - 骨架屏',
        rightText: '空数据',
        rightItemCallBack: () {
          if (!mounted) return;
          setState(() {
            _dataArr = [];
          });
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      enableShimmer: true,
      shimmerView: XbShimmerView.listShimmerView1(context),
      refreshType: RefreshType.bezier,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      itemBuilder: (context, index) => _itemWidget(index),
      separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
    );
  }

  Widget _itemWidget(index) {
    var cell = InkWell(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.red : Colors.yellow,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: Text(_dataArr[index]['name']),
        ),
      ),
      onTap: () => XbProgressHUD.showText(_dataArr[index]['name']),
    );
    return cell;
  }

  void _requestData({isShowLoading = false, isLoadMore = false}) {
    _pageIndex = isLoadMore ? _pageIndex + 1 : 0;
    var params = {
      'page': _pageIndex,
      'size': _limit,
    };
    var loadingText = isShowLoading == true ? 'Loading...' : null;
    globalKeyRefresh.currentState?.xbRequestData(APIS.gpts, params, loadingText: loadingText, isLoadMore: isLoadMore,
        success: (res) {
          var tempData = res['data']['list'];
          setState(() {
            if (isLoadMore) {
              _dataArr = _dataArr + tempData;
            } else {
              _dataArr = tempData;
            }
          });
        }, fail: (code, msg) {});
  }
}

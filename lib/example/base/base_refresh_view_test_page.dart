import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/widgets/base_refresh_view.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/configs/styles.dart';
import 'package:flutter_demo01/http/apis.dart';

class BaseRefreshViewTestPage extends StatefulWidget {
  const BaseRefreshViewTestPage(
    this.jumpParams, {
    Key? key,
  }) : super(key: key);

  final dynamic jumpParams;

  @override
  State<BaseRefreshViewTestPage> createState() => _BaseRefreshViewTestPageState();
}

class _BaseRefreshViewTestPageState extends State<BaseRefreshViewTestPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  final int _limit = 10;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();

    _isGridView = widget.jumpParams['isGridView'];

    Future.delayed(const Duration(milliseconds: 100), () {
      _requestData(isShowLoading: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        _isGridView ? 'BaseGridView' : 'BaseListView',
        rightText: '空数据',
        rightItemCallBack: () {
          if (!mounted) return;
          setState(() {
            _dataArr = [];
          });
        },
      ),
      body: _isGridView ? _gridviewBody() : _listviewBody(),
    );
  }

  Widget _listviewBody() {
    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      // onLoad: _dataArr.length == 0 ? null : () async => _requestData(isLoadMore: true),
      itemBuilder: (context, index) => _itemWidget(index),
      separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
    );
  }

  Widget _gridviewBody() {
    Widget child = GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // 可以直接指定每行（列）显示多少个Item
        crossAxisCount: 2, // 一行的Widget数量
        crossAxisSpacing: 5, // 水平间距
        mainAxisSpacing: 5, // 垂直间距
        childAspectRatio: 1.0, // 子Widget宽高比例
      ),
      // GridView内边距
      padding: const EdgeInsets.all(5),
      itemCount: _dataArr.length,
      itemBuilder: (context, index) {
        return _itemWidget(index);
      },
    );

    return BaseRefreshView(
      key: globalKeyRefresh,
      data: _dataArr,
      limit: _limit,
      child: child,
      onRefresh: () async => _requestData(),
      onLoad: () async => _requestData(isLoadMore: true),
      // onLoad: _dataArr.length == 0 ? null : () async => _requestData(isLoadMore: true),
    );
  }

  Widget _itemWidget(index) {
    return InkWell(
      child: Container(
        width: 100,
        height: 100,
        color: index % 2 == 0 ? Colors.red : Colors.yellow,
        child: Text(_dataArr[index]['name']),
      ),
      onTap: () => XbProgressHUD.showText(_dataArr[index]['name']),
    );
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
      if (!mounted) return;
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

import 'package:flutter/material.dart';
import 'package:flutter_demo01/base_appbar.dart';
import 'package:flutter_demo01/common/utils/xb_common_utils.dart';
import 'package:flutter_demo01/common/widgets/base_refresh_view.dart';
import 'package:flutter_demo01/common/widgets/xb_highlight_text.dart';
import 'package:flutter_demo01/common/widgets/xb_progress_hud.dart';
import 'package:flutter_demo01/common/widgets/xb_shimmer_view.dart';
import 'package:flutter_demo01/common/xb_form/xb_searchbar.dart';
import 'package:flutter_demo01/configs/colors.dart';
import 'package:flutter_demo01/configs/styles.dart';
import 'package:flutter_demo01/http/apis.dart';
import 'package:flutter_demo01/routes/xb_nav_utils.dart';


const _headerHeight = 50.0;

class BaseRefreshViewHeaderFixedPage extends StatefulWidget {
  const BaseRefreshViewHeaderFixedPage({Key? key}) : super(key: key);

  @override
  State<BaseRefreshViewHeaderFixedPage> createState() => _BaseRefreshViewHeaderFixedPageState();
}

class _BaseRefreshViewHeaderFixedPageState extends State<BaseRefreshViewHeaderFixedPage> {
  List _dataArr = [];
  int _pageIndex = 0;
  final int _limit = 15;

  List _searchData = [];
  var _keyWord = '';

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
        'BaseRefreshView - header/footer固定',
        titleWidget: const TwoLinesTitle(title: 'BaseRefreshView', subtitle: 'header/footer固定'),
        rightText: '空数据',
        rightItemCallBack: () {
          if (!mounted) return;
          setState(() {
            _dataArr = [];
          });
        },
        bottomWidget: PreferredSize(preferredSize: const Size.fromHeight(kSearchViewHeight), child: _header()),
      ),
      body: _body(),
      bottomNavigationBar: _footer(),
    );
  }

  Widget _header() {
    return XbSearchBar(
      text: _keyWord,
      hintText: '请输入',
      maxLength: 140,
      textInputAction: TextInputAction.search,
      inputCallBack: (value) {
        XbCommonUtils.debounce(() => _inputCallBack(value, false), 500);
      },
      inputCompletionCallBack: (value, isSubmitted) {
        if (isSubmitted) {
          XbCommonUtils.debounce(() => _inputCallBack(value, true), 500);
        }
      },
    );
  }

  _inputCallBack(value, isSubmitted) {
    var beforeKeyWord = _keyWord;
    setState(() {
      _keyWord = value;
      if (value.isEmpty || isSubmitted) {
        _searchData = [];
      }
      if (value.length >= 3) {
        if (isSubmitted) {
          _requestData(isShowLoading: true);
        } else if (beforeKeyWord != _keyWord) {
          _requestKeywordList(value);
        }
      }
    });
  }

  Widget _footer() {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.orange,
        height: _headerHeight,
        child: const Text('footer', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _body() {
    if (_searchData.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (_, index) {
          return _searchResultItem(index);
        },
        itemCount: _searchData.length,
      );
    } else {
      return BaseRefreshView(
        key: globalKeyRefresh,
        data: _dataArr,
        limit: _limit,
        enableShimmer: true,
        shimmerView: XbShimmerView.listShimmerView1(context),
        emptyText: '暂无数据',
        refreshType: RefreshType.cupertino,
        onRefresh: () async => _requestData(),
        onLoad: () async => _requestData(isLoadMore: true),
        itemBuilder: (context, index) => _itemWidget(index),
        separatorBuilder: (context, index) => KStyles.cellLineGrayStyle,
      );
    }
  }

  Widget _searchResultItem(index) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: KColors.kLineColor, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: XbHighlightText(text: _searchData[index]['name'], highlightText: _keyWord),
            ),
            const Icon(Icons.north_west, size: 15, color: Colors.black),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _keyWord = _searchData[index]['name'];
          _searchData = [];
          XbNavUtils.unFocus();
          Future.delayed(const Duration(milliseconds: 100), () {
            _requestData(isShowLoading: false);
          });
        });
      },
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

  void _requestKeywordList(filter) {
    // var params = {
    //   'filter': filter,
    // };
    var tempArr = [];
    for (var i = 0; i < 20; i++) {
      tempArr.add({'name': filter + i.toString()});
    }
    setState(() {
      _searchData = tempArr;
    });
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter_demo01/pages/tabbar/home_page.dart';
import 'package:flutter_demo01/pages/tabbar/news_page.dart';
import 'package:flutter_demo01/pages/tabbar/profile_page.dart';
import 'package:flutter_demo01/pages/tabbar/vip_page.dart';
import 'package:flutter_demo01/routes/router_init.dart';

class MainRouter implements IRouterProvider {
  static String homePage = '/homePage';
  static String newsPage = '/newsPage';
  static String vipPage = '/vipPage';
  static String profilePage = '/profilePage';

  @override
  void initRouter(FluroRouter router) {
    router.define(homePage,
        handler: Handler(handlerFunc: (_, __) => const HomePage()));
    router.define(newsPage,
        handler: Handler(handlerFunc: (_, __) => const NewsPage()));
    router.define(vipPage,
        handler: Handler(handlerFunc: (_, __) => const VipPage()));
    router.define(profilePage,
        handler: Handler(handlerFunc: (_, __) => const ProfilePage()));
  }
}

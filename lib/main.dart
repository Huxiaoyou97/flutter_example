// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bot_toast/bot_toast.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo01/common/utils/xb_device_utils.dart';
import 'package:flutter_demo01/common/utils/xb_status_bar_utils.dart';
import 'package:flutter_demo01/common/utils/xb_storage_utils.dart';
import 'package:flutter_demo01/http/http_utils.dart';
import 'package:flutter_demo01/http/log_utils.dart';
import 'package:flutter_demo01/intl/intl_config.dart';
import 'package:flutter_demo01/pages/login/login_page.dart';
import 'package:flutter_demo01/provider/socket_provider.dart';
import 'package:flutter_demo01/provider/theme_provider.dart';
import 'package:flutter_demo01/routes/app_route_observer.dart';
import 'package:flutter_demo01/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'base_tabbar.dart';
import 'common/utils/sp_util.dart';
import 'common/utils/xb_screen_utils.dart';
import 'configs/project_config.dart';
import 'configs/strings.dart';
import 'intl/locale_utils.dart';

void main() async {
  /// 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  /// shared_preferences 初始化
  await SpUtil.getInstance();

  bool isNewFeaturePage = await _isNewFeaturePage();

  runApp(MyApp());

  if (XbDeviceUtils.isAndroid) {
    print('Android');
  } else if (XbDeviceUtils.isIOS) {
    print('iOS');
  } else if (XbDeviceUtils.isWeb) {
    print('Web');
  }

  // 设置安卓透明状态栏
  XbStatusBarUtils.setAndroidTransparentBar();
}

/// 是否新版本
Future<bool> _isNewFeaturePage() async {
  String version = await XbDeviceUtils.version();
  var lastVersion = XbAESStorageUtils.getString(kUserDefault_LastVersion);
  print("$lastVersion ====== $version");
  if (lastVersion == null || lastVersion == '') {
    print('首次安装');
    XbAESStorageUtils.saveString(kUserDefault_LastVersion, version);
    return true;
  } else {
    // print(lastVersion.compareTo(version)); // 字符串 比较大小, 0:相同、1:大于、-1:小于
    if (lastVersion.compareTo(version) < 0) {
      print('新版本安装');
      XbAESStorageUtils.saveString(kUserDefault_LastVersion, version);
      return true;
    } else {
      print('正常启动');
      return false;
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    this.isHome = false,
  }) : super(key: key);

  final bool isHome;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    LogUtils.init();
    HttpUtils.initDio();
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => WebSocketProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (_, ThemeProvider provider, __) {
            return _buildMaterialApp(provider);
          },
        ));
    return app;
  }

  Widget _buildMaterialApp(ThemeProvider provider) {
    // 警告:不要随意调整调用BotToastInit函数的位置
    final botToastBuilder = BotToastInit(); // 1.调用BotToastInit

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: KStrings.navigatorKey,
      // 多主题切换
      theme: provider.getThemeData(),
      darkTheme: provider.getThemeData(isDarkMode: true),
      themeMode: provider.getThemeMode(),
      // 单一主题
      // theme: ThemeData(
      //   // primarySwatch包含了primaryColor
      //   primarySwatch: JhColorUtils.materialColor(KColors.kThemeColor),
      //   // 主色
      //   primaryColor: KColors.kThemeColor,
      // ),
      home: _switchRootWidget(),
      // 路由
      onGenerateRoute: Routes.router.generator,
      // onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(builder: (context) => const NotFoundPage()),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FallbackCupertinoLocalisationsDelegate()
      ],
      locale: LocaleUtils.currentLocale,
      fallbackLocale: LocaleUtils.fallbackLocale,
      supportedLocales: LocaleUtils.supportedLocales,
      translations: LangTranslations(),
      builder: (BuildContext context, Widget? child) {
        XbScreenUtils.init(context);

        if (XbDeviceUtils.isAndroid) {
          /// 设置安卓底部虚拟按键颜色
          XbStatusBarUtils.setSystemNavigationBarStyle(
              provider.isDark(context));
        }

        /// 保证文字大小不受手机系统设置影响
        child = MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
        // 1.调用BotToastInit
        child = botToastBuilder(context, child);
        return child;
      },
      // 2.注册路由观察者
      navigatorObservers: [
        BotToastNavigatorObserver(),
        AppRouteObserver().routeObserver
      ],
    );
  }

  Widget _switchRootWidget() {
    // if (widget.isHome == false) {
    //   return const NewFeaturePage();
    // } else {
    //   var modelJson = XbAESStorageUtils.getModel(kUserDefault_UserInfo);
    //   if (modelJson != null) {
    //     // UserModel model = UserModel.fromJson(modelJson);
    //     // print('本地取出的 userName:${model.userName!}');
    //     return const BaseTabBar();
    //   } else {
    //     return const LoginPage();
    //   }
    // }
    var modelJson = XbAESStorageUtils.getModel(kUserDefault_UserInfo);
    if (modelJson == null) {
      // UserModel model = UserModel.fromJson(modelJson);
      // print('本地取出的 userName:${model.userName!}');
      return const BaseTabBar();
    } else {
      return const LoginPage();
    }
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

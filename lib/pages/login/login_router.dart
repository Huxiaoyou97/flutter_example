import 'package:fluro/fluro.dart';
import 'package:flutter_demo01/routes/router_init.dart';

import 'login_page.dart';

class LoginRouter implements IRouterProvider {
  static String pLoginPage = 'LoginPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(pLoginPage, handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    // router.define('RegisterPage', handler: Handler(handlerFunc: (_, __) => const RegisterPage()));
    // router.define('FindPwdPage', handler: Handler(handlerFunc: (_, __) => const FindPwdPage()));
    // router.define('CodeLoginPage', handler: Handler(handlerFunc: (_, __) => const CodeLoginPage()));
    //
    // router.define('NewFeaturePage', handler: Handler(handlerFunc: (_, __) => const NewFeaturePage()));
    // router.define('FullScreenSwiperWidget', handler: Handler(handlerFunc: (_, __) => const FullScreenSwiperWidget()));
  }
}

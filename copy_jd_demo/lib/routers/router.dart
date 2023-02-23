import 'package:flutter/material.dart';
import '../pages/tabs/tab.dart';

import '../pages/tabs/home.dart';
import '../pages/tabs/category.dart';
import '../pages/tabs/user.dart';
import '../pages/tabs/cart.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/category': (context) => CategoryPage(),
  '/user': (context) => UserPage(),
  '/cart': (context) => CartPage()
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

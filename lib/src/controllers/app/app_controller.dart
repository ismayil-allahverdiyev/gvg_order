import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/bindings/login/login_bindings.dart';
import 'package:gvg_order/src/ui/login/login_page.dart';
import '../../bindings/home/home_bindings.dart';
import '../../data/repository/repository.dart';
import '../../ui/home/home_page.dart';

class AppController extends GetxController {
  final Repository repository;
  AppController({required this.repository});

  Route generateRouteControlFunction(RouteSettings route) {
    return GetPageRoute(
      settings: route,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    );
  }
}

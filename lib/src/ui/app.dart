import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app/app_controller.dart';
import '../routes/app_routes.dart';

class AppPage extends GetView<AppController> {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        initialRoute: Routes.HOME,
        onGenerateRoute: controller.generateRouteControlFunction,
      ),
    );
  }
}

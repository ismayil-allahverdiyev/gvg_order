import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/constants/local_storage.dart';
import 'package:gvg_order/src/controllers/local_storage/local_storage_controller.dart';
import 'package:gvg_order/src/data/models/login/login_model.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import '../../data/repository/repository.dart';

class LoginController extends GetxController {
  final Repository repository;
  LoginController({required this.repository});

  LocalStorageController localStorageController = Get.find();

  var emailTextController = TextEditingController(text: "cisemsiparis");
  var passwordTextController = TextEditingController(text: "Siparis123");

  var isRememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getToken() async {
    var result = await repository.postData(
      endpoint:
          "https://test-api-identity-proxy.geovisiongroup.com/api/v1/Connect/get-token",
      base: "",
      object: {
        "username": emailTextController.text,
        "password": passwordTextController.text,
        "realm": "gvg"
      },
    );
    if (result != null) {
      var res = loginModelFromJson(result);

      await localStorageController.saveStringToLocal(
          LocalStorageConst.jwtToken, res.accessToken);
      await localStorageController.saveStringToLocal(
          LocalStorageConst.refreshToken, res.refreshToken);

      Get.toNamed(Routes.OUTLETS);
    }
  }
}

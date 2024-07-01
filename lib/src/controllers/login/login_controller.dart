import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/endpoints.dart';
import 'package:gvg_order/src/constants/local_storage.dart';
import 'package:gvg_order/src/controllers/local_storage/local_storage_controller.dart';
import 'package:gvg_order/src/data/models/login/login_model.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import '../../data/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginController extends GetxController {
  final Repository repository;
  LoginController({required this.repository});

  LocalStorageController localStorageController = Get.find();

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  var isRememberMe = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailTextController.text = localStorageController.getStringFromLocal(
      LocalStorageConst.savedEmail,
    );
  }

  getToken() async {
    isLoading.value = true;
    try {
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
        if (isRememberMe.value) {
          await localStorageController.saveStringToLocal(
              LocalStorageConst.savedEmail, emailTextController.text);
        } else {
          await localStorageController.saveStringToLocal(
              LocalStorageConst.savedEmail, "");
        }

        isLoading.value = false;

        Get.toNamed(Routes.ORDERS);
      }
    } catch (e) {
      isLoading.value = false;
      repository.showMessage(
        title: AppLocalizations.of(Get.context!)!.error,
        message: e.toString(),
      );
    }
  }
}

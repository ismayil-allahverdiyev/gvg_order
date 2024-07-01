import 'package:get/get.dart';
import 'package:gvg_order/src/constants/local_storage.dart';
import 'package:gvg_order/src/controllers/local_storage/local_storage_controller.dart';
import 'package:restart_app/restart_app.dart';

import '../../data/repository/repository.dart';

class LanguageController extends GetxController {
  final Repository repository;
  LanguageController({required this.repository});

  LocalStorageController localStorageController = Get.find();

  var selectedLanguage = "en".obs;

  @override
  void onInit() async {
    super.onInit();
    selectedLanguage.value = localStorageController
                .getStringFromLocal(LocalStorageConst.language) ==
            ""
        ? "en"
        : localStorageController.getStringFromLocal(LocalStorageConst.language);
  }

  setLanguage() {
    selectedLanguage.value = selectedLanguage.value;
    localStorageController.saveStringToLocal(
      LocalStorageConst.language,
      selectedLanguage.value,
    );

    Restart.restartApp();
  }
}

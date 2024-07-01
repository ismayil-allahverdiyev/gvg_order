import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/constants/local_storage.dart';
import 'src/controllers/local_storage/local_storage_controller.dart';
import 'src/data/provider/api_client.dart';
import 'src/data/repository/repository.dart';
import 'src/data/utils/default_options.dart';
import 'src/data/utils/firebase_api.dart';
import 'src/routes/app_pages.dart';
import 'src/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseApi().initPlatformState();

  SharedPreferences.getInstance().then((instance) {
    Get.put(
        LocalStorageController(repository: Repository(apiClient: ApiClient())));
    Get.find<LocalStorageController>().localStorage = instance;
    var localStorageController = Get.find<LocalStorageController>();
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        defaultTransition: Transition.rightToLeft,
        getPages: AppPages.pages,
        locale: Locale(
          localStorageController
                      .getStringFromLocal(LocalStorageConst.language) ==
                  ""
              ? "tr"
              : localStorageController
                  .getStringFromLocal(LocalStorageConst.language),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('tr'), // Turkish
        ],
      ),
    );
  });
}

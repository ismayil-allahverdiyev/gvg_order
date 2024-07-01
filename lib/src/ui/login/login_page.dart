import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/login/login_controller.dart';
import 'package:gvg_order/src/data/provider/api_client.dart';
import 'package:gvg_order/src/data/repository/repository.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_dialog_widget.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_text_field_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import '../../controllers/language/language_controller.dart';
import '../../data/utils/device_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../language/language_dialog.dart';
import '../shared/widgets/custom_loader_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => DeviceUtils.hideKeyboard(context),
          child: Scaffold(
            backgroundColor: const Color(0xfff9fafb),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        Get.put<LanguageController>(
                          LanguageController(
                            repository: Repository(
                              apiClient: ApiClient(),
                            ),
                          ),
                        );

                        await Get.dialog(
                          const LanguageDialog(),
                        );

                        Get.delete<LanguageController>();
                      },
                      icon: const Icon(Icons.translate),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.login,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: const TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enteremail,
                    controller: controller.emailTextController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: const TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enterpassword,
                    controller: controller.passwordTextController,
                    isHidden: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isRememberMe.value =
                                  !controller.isRememberMe.value;
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () {
                                  return Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: controller.isRememberMe.value
                                          ? primaryColor
                                          : whiteColor,
                                      border: Border.all(
                                        color: lightGreyColor,
                                      ),
                                    ),
                                    child: controller.isRememberMe.value
                                        ? const Icon(
                                            Icons.check,
                                            color: whiteColor,
                                            size: 16,
                                          )
                                        : const SizedBox(),
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.rememberme,
                            style: const TextStyle(
                              color: lightTextColor,
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     AppLocalizations.of(context)!.forgotpassword,
                      //     style: const TextStyle(
                      //       color: primaryColor,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.getToken();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () {
            return CustomLoaderPage(
              isLoading: controller.isLoading.value,
            );
          },
        ),
      ],
    );
  }
}

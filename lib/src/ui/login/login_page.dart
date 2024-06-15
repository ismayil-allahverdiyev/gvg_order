import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/login/login_controller.dart';
import 'package:gvg_order/src/ui/shared/widgets/custom_text_field_widget.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import '../../data/utils/device_utils.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: const Color(0xfff9fafb),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              const Text(
                "Log in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Email",
                style: TextStyle(
                  color: lightTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                hintText: "Enter email...",
                controller: controller.emailTextController,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Password",
                style: TextStyle(
                  color: lightTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                hintText: "Enter password...",
                controller: controller.passwordTextController,
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
                      const Text(
                        "Remember me",
                        style: TextStyle(
                          color: lightTextColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.getToken();
                },
                child: const Text("Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

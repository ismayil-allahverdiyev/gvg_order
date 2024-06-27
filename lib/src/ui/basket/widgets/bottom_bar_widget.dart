import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import '../../../controllers/basket/basket_controller.dart';
import '../../theme/app_colors.dart';

class BottomBarWidget extends GetWidget<BasketController> {
  final VoidCallback onPressed;
  const BottomBarWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width / 4,
            child: Column(
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Obx(
                  () {
                    return Text(
                      "${(controller.kdvTotal.value + controller.justKdvTotal.value).toStringAsFixed(2)}\$",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  height: Get.width * 0.12,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/basket/basket_controller.dart';
import 'package:gvg_order/src/controllers/home/home_controller.dart';
import 'package:gvg_order/src/routes/app_routes.dart';

import '../../theme/app_colors.dart';

class BasketWidget extends GetWidget<BasketController> {
  const BasketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          controller.getTemporaryCardInfo();
          await Get.toNamed(Routes.BASKET);
          Get.find<HomeController>().onInit();
        },
        child: Container(
          height: Get.width * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.1,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: primaryColor.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Obx(
                      () {
                        return Text(
                          '${controller.total.value.toString().length > 5 ? "${controller.total.value.toString().substring(0, 4)}..." : controller.total.value} tl',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

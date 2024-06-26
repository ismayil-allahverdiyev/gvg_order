import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home/home_controller.dart';
import 'product_display_widget.dart';

class BodyWidget extends GetWidget<HomeController> {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductDisplayWidget(
              order: controller.orderList[index],
              index: index,
              isCampaign: controller.selectedTab.value == 1,
            );
          },
          itemCount: controller.orderList.length,
        );
      },
    );
  }
}

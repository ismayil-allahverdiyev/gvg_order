import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/basket/basket_controller.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'widgets/basket_product_widget.dart';
import 'widgets/bottom_bar_widget.dart';

class BasketPage extends GetView<BasketController> {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'My basket',
          style: TextStyle(
            color: lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.xmark,
            color: lightTextColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.trash,
              color: lightTextColor,
            ),
            onPressed: () {
              controller.basketList.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: controller.basketList.length,
                  itemBuilder: (context, index) => BasketProductWidget(
                    key: ValueKey(controller.basketList[index].productId),
                    product: controller.basketList[index],
                    isLast: index == controller.basketList.length - 1,
                  ),
                );
              },
            ),
          ),
          Obx(
            () {
              return Text(
                "Tostal KDV: " +
                    controller.justKdvTotal.value.toStringAsFixed(2) +
                    '\$',
                style: TextStyle(
                  color: lightTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            },
          ),
          const Divider(),
          BottomBarWidget(
            onPressed: () => Get.toNamed(Routes.PAYMENT),
          )
        ],
      ),
    );
  }
}

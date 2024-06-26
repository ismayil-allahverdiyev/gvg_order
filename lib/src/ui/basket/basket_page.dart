import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/controllers/basket/basket_controller.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import 'package:gvg_order/src/ui/theme/app_colors.dart';
import 'widgets/basket_product_widget.dart';
import 'widgets/bottom_bar_widget.dart';
import 'widgets/custom_basket_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketPage extends GetView<BasketController> {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Text(
              AppLocalizations.of(context)!.mybasket,
              style: const TextStyle(
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
                        index: index,
                      ),
                    );
                  },
                ),
              ),
              Obx(
                () {
                  return Text(
                    "${AppLocalizations.of(context)!.totalkdv} ${controller.justKdvTotal.value.toStringAsFixed(2)}\$",
                    style: const TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              const Divider(),
              BottomBarWidget(
                onPressed: () {
                  Get.dialog(
                    const CustomBasketDialog(),
                  );
                },
              )
            ],
          ),
        ),
        Positioned(
          child: Obx(
            () {
              return controller.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        )
      ],
    );
  }
}

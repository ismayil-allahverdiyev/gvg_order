import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/constants/assets.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import 'package:gvg_order/src/routes/app_routes.dart';
import '../../../controllers/home/home_controller.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDisplayWidget extends GetWidget<HomeController> {
  final OrderList order;
  final int index;
  final bool isCampaign;
  const ProductDisplayWidget({
    super.key,
    required this.order,
    required this.index,
    required this.isCampaign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.PRODUCT,
        arguments: {
          'productId': isCampaign ? order.id : order.productId,
          'selectedCount': 0,
          'availableProductCount': 30,
          'isCampaign': isCampaign,
          'listId': order.productListId,
        },
      ),
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.09 / 2,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Hero(
                    tag: order.productId.toString(),
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: lightGreyColor,
                          ),
                          image:
                              controller.orderList[index].imageFile == null ||
                                      controller.orderList[index].imageFile!
                                              .image ==
                                          null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                        Assets.image_placeholder,
                                      ),
                                      scale: 5,
                                    )
                                  : DecorationImage(
                                      image: controller.orderList[index]
                                          .imageFile!.image!.image,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Get.width / 6 * 0.25,
                      right: Get.width / 6 * 0.1,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Get.width / 6 * 0.25,
                      right: Get.width / 6 * 0.1,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "${order.listPrice} tl",
                              style: TextStyle(
                                color:
                                    order.listPrice != order.discountedListPrice
                                        ? redColor
                                        : null,
                                decoration:
                                    order.listPrice != order.discountedListPrice
                                        ? TextDecoration.lineThrough
                                        : null,
                                decorationColor: primaryColor,
                              ),
                            ),
                            const TextSpan(
                              text: " ",
                            ),
                            if (order.listPrice != order.discountedListPrice)
                              TextSpan(
                                text: "${order.listPrice} tl",
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: Get.width / 6 * 0.15,
                top: -12,
                child: GetBuilder<HomeController>(
                  id: "orderList",
                  builder: (controller) {
                    return controller.orderList[index].isFavorite
                        ? const Icon(
                            Icons.star_rounded,
                            color: Colors.orangeAccent,
                            size: 32,
                          )
                        : const SizedBox();
                  },
                ),
              ),
              Positioned(
                top: -Get.width * 0.05,
                right: 0,
                child: GetBuilder<HomeController>(
                    id: "orderList",
                    builder: (sizeController) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: Get.width * 0.09 + 16,
                        height:
                            sizeController.orderList[index].selectedCount > 0
                                ? Get.width * 0.27 + 34
                                : Get.width * 0.09 + 34,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => controller.updateProductCount(
                                product: order,
                                isAdd: true,
                              ),
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: GetBuilder<HomeController>(
                                    id: "orderList",
                                    builder: (tapController) {
                                      return Container(
                                        height: Get.width * 0.09,
                                        width: Get.width * 0.09,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(8),
                                            topRight: const Radius.circular(8),
                                            bottomLeft: tapController
                                                        .orderList[index]
                                                        .selectedCount >
                                                    0
                                                ? Radius.zero
                                                : const Radius.circular(8),
                                            bottomRight: tapController
                                                        .orderList[index]
                                                        .selectedCount >
                                                    0
                                                ? Radius.zero
                                                : const Radius.circular(8),
                                          ),
                                          border: Border(
                                            left: const BorderSide(
                                              color: primaryColor,
                                              width: 1,
                                            ),
                                            right: const BorderSide(
                                              color: primaryColor,
                                              width: 1,
                                            ),
                                            top: const BorderSide(
                                              color: primaryColor,
                                              width: 1,
                                            ),
                                            bottom: tapController
                                                        .orderList[index]
                                                        .selectedCount >
                                                    0
                                                ? BorderSide.none
                                                : const BorderSide(
                                                    color: primaryColor,
                                                    width: 1,
                                                  ),
                                          ),
                                          color: whiteColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: primaryColor,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            GetBuilder<HomeController>(
                                id: "orderList",
                                builder: (countController) {
                                  return AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    child: countController.orderList[index]
                                                .selectedCount >
                                            0
                                        ? SizedBox(
                                            height: countController
                                                        .orderList[index]
                                                        .selectedCount >
                                                    0
                                                ? Get.width * 0.18 + 9
                                                : 0,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Container(
                                                    height: Get.width * 0.09,
                                                    width: Get.width * 0.09,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                        255,
                                                        244,
                                                        241,
                                                        254,
                                                      ),
                                                      border: const Border(
                                                        left: BorderSide(
                                                          color: primaryColor,
                                                          width: 1,
                                                        ),
                                                        right: BorderSide(
                                                          color: primaryColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: GetBuilder<
                                                          HomeController>(
                                                        id: "orderList",
                                                        builder: (controller) {
                                                          return Text(
                                                            controller
                                                                .orderList[
                                                                    index]
                                                                .selectedCount
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => controller
                                                      .updateProductCount(
                                                    product: order,
                                                    isAdd: false,
                                                  ),
                                                  behavior: HitTestBehavior
                                                      .translucent,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 8, 8),
                                                    child: Container(
                                                      height: Get.width * 0.09,
                                                      width: Get.width * 0.09,
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8),
                                                        ),
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: primaryColor,
                                                            width: 1,
                                                          ),
                                                          right: BorderSide(
                                                            color: primaryColor,
                                                            width: 1,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: primaryColor,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        color: whiteColor,
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  );
                                }),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 4,
      height: Get.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: lightGreyColor.withOpacity(0.2),
        border: Border.all(
          color: lightGreyColor,
        ),
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}

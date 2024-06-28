import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gvg_order/src/data/models/order_list/order_list_model.dart';
import '../../../constants/assets.dart';
import '../../../controllers/basket/basket_controller.dart';
import '../../../routes/app_routes.dart';
import '../../shared/widgets/custom_progress_indicator_widget.dart';
import '../../theme/app_colors.dart';
import 'background_widget.dart';

class BasketProductWidget extends GetWidget<BasketController> {
  final OrderList product;
  final int index;
  final bool isLast;
  const BasketProductWidget({
    super.key,
    required this.product,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return Future.value(true);
      },
      background: const BasketBackgroundWidget(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.PRODUCT,
                  arguments: {
                    'productId': product.productId,
                    'selectedCount': 1,
                    'availableProductCount': 30,
                    'listId': product.productListId,
                  },
                );
              },
              child: Row(
                children: [
                  Obx(() {
                    return Container(
                      width: Get.width * 0.2,
                      height: Get.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: lightGreyColor,
                        ),
                        image: controller.basketList[index].imageFile == null ||
                                controller.basketList[index].imageFile!.image ==
                                    null
                            ? const DecorationImage(
                                image: AssetImage(
                                  Assets.image_placeholder,
                                ),
                                scale: 5,
                              )
                            : DecorationImage(
                                image: controller
                                    .basketList[index].imageFile!.image!.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  }),
                  // CachedNetworkImage(
                  //   imageUrl:
                  //       "https://media.istockphoto.com/id/458464735/tr/foto%C4%9Fraf/coke.jpg?s=2048x2048&w=is&k=20&c=DpnH4v1YRs4l1rmzu-xFi3wRjK44FUTYQBD8FJTwHx0=",
                  //   imageBuilder: (context, imageProvider) => Container(
                  //     width: Get.width * 0.2,
                  //     height: Get.width * 0.2,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(
                  //         color: lightGreyColor,
                  //       ),
                  //       image: DecorationImage(
                  //         image: imageProvider,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  //   placeholder: (context, url) => const PlaceHolderWidget(),
                  //   errorWidget: (context, url, error) =>
                  //       const PlaceHolderWidget(),
                  // ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.productName,
                          maxLines: 2,
                          style: const TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GetBuilder<BasketController>(
                            id: "basketList",
                            builder: (controller) {
                              return RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${product.discountedListPrice * controller.basketList[index].selectedCount} tl",
                                    ),
                                    TextSpan(
                                      text:
                                          " + ${controller.kdvProducts[index].kdv} tl",
                                      style: const TextStyle(
                                        color: lightTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: Get.width * 0.24,
                    height: Get.width * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              product.selectedCount++;
                              controller.editBasketList(orderList: product);
                            },
                            child: const Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: primaryColor.withOpacity(0.1),
                            child: Center(
                              child: GetBuilder<BasketController>(
                                id: "basketList",
                                builder: (controller) {
                                  return Text(
                                    controller.basketList[index].selectedCount
                                        .toString(),
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              product.selectedCount--;
                              controller.editBasketList(orderList: product);
                            },
                            child: const Icon(
                              Icons.remove,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          !isLast
              ? const Divider(
                  endIndent: 12,
                  indent: 12,
                )
              : const SizedBox()
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
      width: Get.width * 0.2,
      height: Get.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: lightGreyColor,
        ),
        color: lightGreyColor,
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
